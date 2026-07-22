import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:kidquest/models/child.dart';

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

import 'package:kidquest/widgets/dashboard/child_overview_card.dart';
import 'package:kidquest/widgets/dashboard/children_section.dart';
import 'package:kidquest/widgets/dashboard/dashboard_stats_row.dart';
import 'package:kidquest/widgets/dashboard/parent_hero_section.dart';
import 'package:kidquest/widgets/dashboard/quick_action_card.dart';
import 'package:kidquest/widgets/dashboard/routine_banner.dart';

class ParentDashboardScreen extends StatefulWidget {
  const ParentDashboardScreen({super.key});

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

  Future<Map<String, dynamic>>? dashboardFuture;

  @override
  void initState() {
    super.initState();
    dashboardFuture = _loadDashboard();
  }

  Future<Map<String, dynamic>> _loadDashboard() async {
    final uid =
        FirebaseAuth.instance.currentUser!.uid;

    final parent =
        await _parentService.getParent(uid);

    /// Fetch complete child list instead of only count
    final List<Child> children =
        await _childService.getChildren(uid).first;

    final totalXp =
        await _dashboardService.getTotalXP(uid);

    final totalTasks =
        await _dashboardService.getTaskCount();

    final rewards =
        await _dashboardService.getRewardCount();

    return {
      'name': parent?['name'] ?? 'Parent',

      /// Actual children list
      'children': children,

      /// Count used by Hero & Stats cards
      'childrenCount': children.length,

      'xp': totalXp,
      'tasks': totalTasks,
      'rewards': rewards,
    };
  }

  Future<void> refreshDashboard() async {
    setState(() {
      dashboardFuture = _loadDashboard();
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
        child: CircularProgressIndicator(),
      ),
    );

    try {
      final children =
          await _childService.getChildren(uid).first;

      for (final child in children) {
        await _taskService.generateDailyTasks(
          child.id,
        );
      }

      if (!mounted) return;

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Today's routine generated successfully 🎉",
          ),
        ),
      );

      refreshDashboard();
    } catch (e) {
      if (!mounted) return;

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();

    await SessionService().clearSession();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const RoleSelectionScreen(),
      ),
      (_) => false,
    );
  }  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),

      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: const Text(
          "Parent Dashboard",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        actions: [
          IconButton(
            tooltip: "Analytics",
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.analytics_outlined,
                color: Colors.indigo,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AnalyticsScreen(),
                ),
              );
            },
          ),

          const SizedBox(width: 8),

          IconButton(
            tooltip: "Logout",
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
            ),
            onPressed: _logout,
          ),

          const SizedBox(width: 16),
        ],
      ),

      body: FutureBuilder<Map<String, dynamic>>(
        future: dashboardFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text("No dashboard data found"),
            );
          }

          final data = snapshot.data!;

          final children =
              data["children"] as List<Child>;

          return RefreshIndicator(
            onRefresh: refreshDashboard,
            child: ListView(
              physics:
                  const BouncingScrollPhysics(),
              padding:
                  const EdgeInsets.fromLTRB(
                20,
                10,
                20,
                120,
              ),
              children: [
                ParentHeroSection(
                  parentName: data["name"],
                  children: data["childrenCount"],
                  xp: data["xp"],
                ),

                const SizedBox(height: 24),

                DashboardStatsRow(
                  children:
                      data["childrenCount"],
                  tasks: data["tasks"],
                  xp: data["xp"],
                ),

                const SizedBox(height: 24),

                ChildOverviewCard(
                  name: "Family Progress",
                  level: 8,
                  xp: data["xp"],
                ),

                const SizedBox(height: 24),

                RoutineBanner(
                  onGenerate: generateRoutine,
                ),

                const SizedBox(height: 28),

                /// Real children from Firestore
                ChildrenSection(
                  children: children,
                ),

                const SizedBox(height: 30),

                Container(
                  padding:
                      const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withValues(alpha: .05),
                        blurRadius: 18,
                        offset:
                            const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Today's Summary",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: _summaryTile(
                              Icons.assignment,
                              "Tasks",
                              "${data["tasks"]}",
                              Colors.green,
                            ),
                          ),

                          const SizedBox(
                            width: 12,
                          ),

                          Expanded(
                            child: _summaryTile(
                              Icons.star,
                              "XP",
                              "${data["xp"]}",
                              Colors.orange,
                            ),
                          ),

                          const SizedBox(
                            width: 12,
                          ),

                          Expanded(
                            child: _summaryTile(
                              Icons.card_giftcard,
                              "Rewards",
                              "${data["rewards"]}",
                              Colors.purple,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 34),                Row(
                  children: [
                    const Text(
                      "Quick Actions",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withValues(alpha: .08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "6 Actions",
                        style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                    childAspectRatio: .95,
                  ),
                  itemBuilder: (context, index) {
                    final actions = [
                      (
                        Icons.person_add_alt_1_rounded,
                        "Add Child",
                        Colors.blue,
                        () async {
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
                      (
                        Icons.groups_rounded,
                        "My Children",
                        Colors.green,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const MyChildrenScreen(),
                            ),
                          );
                        },
                      ),
                      (
                        Icons.assignment_rounded,
                        "Tasks",
                        Colors.orange,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ViewTasksScreen(),
                            ),
                          );
                        },
                      ),
                      (
                        Icons.card_giftcard_rounded,
                        "Rewards",
                        Colors.red,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const CreateRewardScreen(),
                            ),
                          );
                        },
                      ),
                      (
                        Icons.redeem_rounded,
                        "Reward Store",
                        Colors.teal,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ViewRewardsScreen(),
                            ),
                          );
                        },
                      ),
                      (
                        Icons.analytics_rounded,
                        "Analytics",
                        Colors.deepPurple,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const AnalyticsScreen(),
                            ),
                          );
                        },
                      ),
                    ];

                    final item = actions[index];

                    return QuickActionCard(
                      icon: item.$1,
                      title: item.$2,
                      color: item.$3,
                      onTap: item.$4,
                    );
                  },
                ),

                const SizedBox(height: 50),
              ],
            ),
          );
        },
      ),
    );
  }  Widget _summaryTile(
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),

          const SizedBox(height: 10),

          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}