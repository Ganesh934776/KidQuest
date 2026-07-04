import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:kidquest/screens/common/role_selection_screen.dart';
import 'package:kidquest/screens/parent/add_child_screen.dart';
import 'package:kidquest/screens/parent/create_reward_screen.dart';
import 'package:kidquest/screens/parent/create_task_screen.dart';
import 'package:kidquest/screens/parent/my_children_screen.dart';
import 'package:kidquest/screens/parent/view_rewards_screen.dart';
import 'package:kidquest/screens/parent/view_tasks_screen.dart';

import 'package:kidquest/services/dashboard_service.dart';
import 'package:kidquest/services/parent_service.dart';

import 'package:kidquest/widgets/dashboard/dashboard_header_card.dart';
import 'package:kidquest/widgets/dashboard/dashboard_stat_card.dart';
import 'package:kidquest/widgets/dashboard/quick_action_card.dart';

class ParentDashboardScreen extends StatefulWidget {
  const ParentDashboardScreen({super.key});

  @override
  State<ParentDashboardScreen> createState() =>
      _ParentDashboardScreenState();
}

class _ParentDashboardScreenState
    extends State<ParentDashboardScreen> {
  final DashboardService _dashboardService = DashboardService();

  late Future<Map<String, dynamic>> _dashboardData;

  Future<Map<String, dynamic>> _loadDashboard() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final parent =
        await ParentService().getParent(uid);

    final children =
        await _dashboardService.getChildrenCount(uid);

    final xp =
        await _dashboardService.getTotalXP(uid);

    final tasks =
        await _dashboardService.getTaskCount();

    final rewards =
        await _dashboardService.getRewardCount();

    return {
      "name": parent?["name"] ?? "Parent",
      "children": children,
      "xp": xp,
      "tasks": tasks,
      "rewards": rewards,
    };
  }

  @override
  void initState() {
    super.initState();
    _dashboardData = _loadDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Parent Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
  final navigator = Navigator.of(context);

  await FirebaseAuth.instance.signOut();

  if (!mounted) return;

  navigator.pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (_) => const RoleSelectionScreen(),
    ),
    (_) => false,
  );
},
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _dashboardData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [

                DashboardHeaderCard(
                  parentName: data["name"],
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    DashboardStatCard(
                      icon: Icons.child_care,
                      title: "Children",
                      value: "${data["children"]}",
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 12),
                    DashboardStatCard(
                      icon: Icons.star,
                      title: "Family XP",
                      value: "${data["xp"]}",
                      color: Colors.orange,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    DashboardStatCard(
                      icon: Icons.assignment,
                      title: "Tasks",
                      value: "${data["tasks"]}",
                      color: Colors.green,
                    ),
                    const SizedBox(width: 12),
                    DashboardStatCard(
                      icon: Icons.card_giftcard,
                      title: "Rewards",
                      value: "${data["rewards"]}",
                      color: Colors.purple,
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                GridView.count(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1.15,
                  children: [

                    QuickActionCard(
                      icon: Icons.person_add,
                      title: "Add Child",
                      color: Colors.blue,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const AddChildScreen(),
                          ),
                        );
                      },
                    ),

                    QuickActionCard(
                      icon: Icons.people,
                      title: "My Children",
                      color: Colors.green,
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
                      icon: Icons.assignment,
                      title: "Create Task",
                      color: Colors.orange,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const CreateTaskScreen(),
                          ),
                        );
                      },
                    ),

                    QuickActionCard(
                      icon: Icons.list_alt,
                      title: "View Tasks",
                      color: Colors.deepPurple,
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
                      icon: Icons.card_giftcard,
                      title: "Create Reward",
                      color: Colors.red,
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
                      icon: Icons.redeem,
                      title: "View Rewards",
                      color: Colors.teal,
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
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}