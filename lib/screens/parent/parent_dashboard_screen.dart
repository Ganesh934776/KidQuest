import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:kidquest/theme/app_colors.dart';
import 'package:kidquest/theme/app_spacing.dart';
import 'package:kidquest/theme/app_text_styles.dart';

import 'package:kidquest/screens/common/role_selection_screen.dart';
import 'package:kidquest/screens/parent/add_child_screen.dart';
import 'package:kidquest/screens/parent/analytics_screen.dart';
import 'package:kidquest/screens/parent/create_reward_screen.dart';
import 'package:kidquest/screens/parent/my_children_screen.dart';
import 'package:kidquest/screens/parent/view_rewards_screen.dart';
import 'package:kidquest/screens/parent/view_tasks_screen.dart';

import 'package:kidquest/services/child_service.dart';
import 'package:kidquest/services/dashboard_service.dart';
import 'package:kidquest/services/parent_service.dart';
import 'package:kidquest/services/session_service.dart';
import 'package:kidquest/services/task_service.dart';

import 'package:kidquest/widgets/cards/stat_card.dart';

import 'package:kidquest/widgets/dashboard/quick_action_card.dart';
import 'package:kidquest/widgets/dashboard/premium_parent_header.dart';

class ParentDashboardScreen extends StatefulWidget {
  const ParentDashboardScreen({
    super.key,
  });

  @override
  State<ParentDashboardScreen> createState() =>
      _ParentDashboardScreenState();
}

class _ParentDashboardScreenState
    extends State<ParentDashboardScreen> {
  final DashboardService _dashboardService =
      DashboardService();

  final ParentService _parentService =
      ParentService();

  final ChildService _childService =
      ChildService();

  final TaskService _taskService =
      TaskService();

  Future<Map<String, dynamic>>?
      dashboardFuture;

  @override
  void initState() {
    super.initState();
    dashboardFuture = _loadDashboard();
  }

  Future<Map<String, dynamic>>
      _loadDashboard() async {
    final uid =
        FirebaseAuth.instance.currentUser!.uid;

    final parent =
        await _parentService.getParent(uid);

    final children =
        await _dashboardService
            .getChildrenCount(uid);

    final xp =
        await _dashboardService
            .getTotalXP(uid);

    final tasks =
        await _dashboardService
            .getTaskCount();

    final rewards =
        await _dashboardService
            .getRewardCount();

    return {
      "name":
          parent?["name"] ?? "Parent",
      "children": children,
      "xp": xp,
      "tasks": tasks,
      "rewards": rewards,
    };
  }

  Future<void> refreshDashboard() async {
    setState(() {
      dashboardFuture =
          _loadDashboard();
    });

    await dashboardFuture;
  }

  Future<void> generateRoutine() async {
    final uid =
        FirebaseAuth.instance.currentUser!.uid;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child:
            CircularProgressIndicator(),
      ),
    );

    try {
      final children =
          await _childService
              .getChildren(uid)
              .first;

      for (final child in children) {
        await _taskService
            .generateDailyTasks(
          child.id,
        );
      }

      if (!mounted) return;

      Navigator.pop(context);

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          backgroundColor:
              Colors.green,
          content: Text(
            "Today's routine generated successfully 🎉",
          ),
        ),
      );

      refreshDashboard();
    } catch (e) {
      if (!mounted) return;

      Navigator.pop(context);

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance
        .signOut();

    await SessionService()
        .clearSession();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const RoleSelectionScreen(),
      ),
      (route) => false,
    );
  }@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.background,

    appBar: AppBar(
      elevation: 0,
      centerTitle: true,
      title: const Text(
        "Parent Dashboard",
      ),
      actions: [
        IconButton(
          tooltip: "Analytics",
          icon: const Icon(
            Icons.analytics_outlined,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const AnalyticsScreen(),
              ),
            );
          },
        ),
        IconButton(
          tooltip: "Logout",
          icon: const Icon(
            Icons.logout,
          ),
          onPressed: _logout,
        ),
      ],
    ),

    body: FutureBuilder<Map<String, dynamic>>(
      future: dashboardFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(
            child:
                CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text(
              "No dashboard data found.",
            ),
          );
        }

        final data = snapshot.data!;

        return RefreshIndicator(
          onRefresh: refreshDashboard,
          child: ListView(
            physics:
                const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(
              AppSpacing.lg,
            ),
            children: [

             PremiumParentHeader(
  parentName: data["name"],
  children: data["children"],
  totalXp: data["xp"],
),
              const SizedBox(
                height: 28,
              ),

              Text(
                "Family Overview",
                style:
                    AppTextStyles.title,
              ),

              const SizedBox(
                height: 16,
              ),

              GridView.count(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1.15,
                children: [

                  StatCard(
                    icon:
                        Icons.child_care,
                    title: "Children",
                    value:
                        "${data["children"]}",
                    color:
                        AppColors.primary,
                  ),

                  StatCard(
                    icon: Icons.star,
                    title: "Total XP",
                    value:
                        "${data["xp"]}",
                    color:
                        AppColors.xp,
                  ),

                  StatCard(
                    icon:
                        Icons.assignment,
                    title: "Tasks",
                    value:
                        "${data["tasks"]}",
                    color:
                        Colors.green,
                  ),

                  StatCard(
                    icon: Icons.card_giftcard,
                    title: "Rewards",
                    value:
                        "${data["rewards"]}",
                    color:
                        Colors.deepPurple,
                  ),
                ],
              ),

              const SizedBox(
                height: 30,
              ),

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(
                  22,
                ),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(
                    24,
                  ),
                  gradient:
                      const LinearGradient(
                    colors: [
                      Color(
                          0xffFF7043),
                      Color(
                          0xffF4511E),
                    ],
                  ),
                ),
                child: Column(
                  children: [

                    const Icon(
                      Icons.auto_awesome,
                      size: 58,
                      color:
                          Colors.white,
                    ),

                    const SizedBox(
                      height: 14,
                    ),

                    const Text(
                      "Generate Today's Routine",
                      textAlign:
                          TextAlign.center,
                      style:
                          TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            Colors.white,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    const Text(
                      "Generate daily tasks for every child with one tap.",
                      textAlign:
                          TextAlign.center,
                      style:
                          TextStyle(
                        color:
                            Colors.white70,
                      ),
                    ),

                    const SizedBox(
                      height: 22,
                    ),

                    SizedBox(
                      width:
                          double.infinity,
                      height: 52,
                      child:
                          ElevatedButton.icon(
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.white,
                          foregroundColor:
                              Colors.deepOrange,
                        ),
                        icon:
                            const Icon(
                          Icons.play_arrow,
                        ),
                        label:
                            const Text(
                          "Generate Routine",
                        ),
                        onPressed:
                            generateRoutine,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              Text(
                "Quick Actions",
                style:
                    AppTextStyles.title,
              ),

              const SizedBox(
                height: 18,
              ),

              GridView.count(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.05,
                children: [

                  QuickActionCard(
                    icon:
                        Icons.person_add,
                    title:
                        "Add Child",
                    color:
                        Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const AddChildScreen(),
                        ),
                      ).then(
                        (_) =>
                            refreshDashboard(),
                      );
                    },
                  ),

                  QuickActionCard(
                    icon:
                        Icons.people,
                    title:
                        "My Children",
                    color:
                        Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const MyChildrenScreen(),
                        ),
                      );
                    },
                  ),

                  QuickActionCard(
                    icon:
                        Icons.assignment,
                    title:
                        "View Tasks",
                    color:
                        Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ViewTasksScreen(),
                        ),
                      );
                    },
                  ),

                  QuickActionCard(
                    icon:
                        Icons.card_giftcard,
                    title:
                        "Create Reward",
                    color:
                        Colors.red,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const CreateRewardScreen(),
                        ),
                      );
                    },
                  ),

                  QuickActionCard(
                    icon:
                        Icons.redeem,
                    title:
                        "Rewards",
                    color:
                        Colors.teal,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ViewRewardsScreen(),
                        ),
                      );
                    },
                  ),

                  QuickActionCard(
                    icon:
                        Icons.analytics,
                    title:
                        "Analytics",
                    color:
                        Colors.indigo,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const AnalyticsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(
                height: 40,
              ),
            ],
          ),
        );
      },
    ),floatingActionButton: FloatingActionButton.extended(
  heroTag: "addChildFab",
  backgroundColor: AppColors.primary,
  foregroundColor: Colors.white,
  elevation: 8,
  icon: const Icon(Icons.person_add),
  label: const Text(
    "Add Child",
    style: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
  onPressed: () async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const AddChildScreen(),
      ),
    );

    if (!mounted) return;

    refreshDashboard();
  },
),
  );
}
}