import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:kidquest/models/child.dart';
import 'package:kidquest/models/task.dart';

import 'package:kidquest/screens/child/achievements_screen.dart';
import 'package:kidquest/screens/child/reward_store_screen.dart';
import 'package:kidquest/screens/common/leaderboard_screen.dart';
import 'package:kidquest/screens/common/role_selection_screen.dart';

import 'package:kidquest/services/celebration_service.dart';
import 'package:kidquest/services/child_service.dart';
import 'package:kidquest/services/session_service.dart';
import 'package:kidquest/services/task_service.dart';

import 'package:kidquest/utils/level_helper.dart';

import 'package:kidquest/widgets/animations/level_up_dialog.dart';

import 'package:kidquest/widgets/dashboard/adventure_greeting_card.dart';

import 'package:kidquest/widgets/dashboard/dashboard_button.dart';

import 'package:kidquest/widgets/dashboard/level_progress_card.dart';
import 'package:kidquest/widgets/dashboard/section_title.dart';

import 'package:kidquest/widgets/dashboard/premium_stats_card.dart';

import 'package:kidquest/widgets/task_card.dart';
import 'package:kidquest/widgets/dashboard/daily_progress_card.dart';
import 'package:kidquest/widgets/nibble/nibble_card.dart';
import 'package:kidquest/widgets/world/forest_progress_card.dart';
import 'package:kidquest/widgets/rewards/treasure_chest_card.dart';
import 'package:kidquest/widgets/rewards/treasure_reward_dialog.dart';
import 'package:kidquest/widgets/dashboard/premium_header.dart';
import 'package:kidquest/screens/child/my_world_screen.dart';
import 'package:kidquest/screens/child/pet_screen.dart';
import 'package:kidquest/services/adventure_service.dart';
import 'package:kidquest/widgets/dashboard/adventure_card.dart';
import 'package:kidquest/widgets/rewards/daily_login_calendar.dart';

class ChildDashboardScreen extends StatefulWidget {
  final String childId;

  const ChildDashboardScreen({
    super.key,
    required this.childId,
  });

  @override
  State<ChildDashboardScreen> createState() =>
      _ChildDashboardScreenState();
}

class _ChildDashboardScreenState
    extends State<ChildDashboardScreen> {
  final ChildService _childService =
      ChildService();

  final TaskService _taskService =
      TaskService();
     @override
void initState() {
  super.initState();

  Future.microtask(() async {
    await _taskService.generateDailyTasks(widget.childId);
  });
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
      (route) => false,
    );
  }  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kid Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: StreamBuilder<Child>(
        stream: _childService.getChild(
          widget.childId,
        ),
       builder: (context, childSnapshot) {
  if (childSnapshot.hasError) {
    return Center(
      child: Text(
        "Child Error: ${childSnapshot.error}",
      ),
    );
  }

  if (childSnapshot.connectionState ==
      ConnectionState.waiting) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
  

  if (!childSnapshot.hasData) {
    return const Center(
      child: Text("Child not found"),
    );
  }

          final child = childSnapshot.data!;

          final level =
              LevelHelper.getLevel(child.xp);

          final progress =
              LevelHelper.getProgress(child.xp);

          final currentXP =
              LevelHelper.getCurrentLevelXP(
            child.xp,
          );

          final requiredXP =
              LevelHelper.getRequiredXP(level);

          return StreamBuilder<List<Task>>(
            stream:
                _taskService.getTasksForChild(
              widget.childId,
            ),
           builder: (context, taskSnapshot) {
  if (taskSnapshot.hasError) {
    return Center(
      child: Text(
        "Task Error: ${taskSnapshot.error}",
      ),
    );
  }
  

  if (taskSnapshot.connectionState ==
      ConnectionState.waiting) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  if (!taskSnapshot.hasData) {
    return const Center(
      child: Text("No task data"),
    );
  }

             final tasks = [...taskSnapshot.data!];
             final adventure = AdventureService.getTodayAdventure();

tasks.sort(
  (a, b) => a.submissionTime.compareTo(b.submissionTime),
);

final completedTasks =
    tasks.where((e) => e.isCompleted).length;

final unlocked =
    tasks.isNotEmpty &&
    completedTasks == tasks.length;

return SingleChildScrollView(
                padding:
                    const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .stretch,
                  children: [
                    AdventureGreetingCard(
  childName: child.name,
  level: level,
  streak: child.streak,
  coins: child.coins,
),
DailyLoginCalendar(
  childId: widget.childId,
),

const SizedBox(height: 12),
const SizedBox(height: 12),

DailyProgressCard(
  completed:
      tasks.where((e) => e.isCompleted).length,
  total: tasks.length,
),


const SizedBox(height: 12),

                    const SizedBox(height: 12),

                   PremiumStatsCard(
  level: level,
  streak: child.streak,
  coins: child.coins,
),
DashboardButton(
  title: "Dragon",
  icon: Icons.pets,
  color: Colors.deepOrange,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PetScreen(
          xp: child.xp,
        ),
      ),
    );
  },
),

const SizedBox(height: 12),

LevelProgressCard(
  level: level,
  progress: progress,
  currentXP: currentXP,
  requiredXP: requiredXP,
  remainingXP: LevelHelper.getRemainingXP(
    child.xp,
  ),
  levelName: LevelHelper.getLevelName(
    level,
  ),
),
PremiumHeader(
  childName: child.name,
  level: level,
  coins: child.coins,
  streak: child.streak,
  currentXP: currentXP,
  requiredXP: requiredXP,
  progress: progress,
),
DashboardButton(
  title: "My World",
  icon: Icons.public,
  color: Colors.teal,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const MyWorldScreen(),
      ),
    );
  },
),
NibbleCard(
  level: level,
  happiness: 85,
  energy: 70,
  message: "Let's finish today's adventures!",
),
ForestProgressCard(
    completed:
        tasks.where((e)=>e.isCompleted).length,
    total: tasks.length,
),
TreasureChestCard(
  unlocked: unlocked,
  onOpen: () {

   showDialog(
  context: context,
  builder: (_) => const TreasureRewardDialog(),
);

  },
),

const SizedBox(height: 12),

const SizedBox(height:12),

const SizedBox(height: 12),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        DashboardButton(
                          title: "Rewards",
                          icon:
                              Icons.card_giftcard,
                          color: Colors.orange,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    RewardStoreScreen(
                                  childId:
                                      widget
                                          .childId,
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(
                          width: 12,
                        ),

                        DashboardButton(
                          title:
                              "Achievements",
                          icon:
                              Icons.emoji_events,
                          color: Colors.green,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    AchievementsScreen(
                                  childId:
                                      widget
                                          .childId,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        DashboardButton(
                          title:
                              "Leaderboard",
                          icon:
                              Icons.leaderboard,
                          color: Colors.blue,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    LeaderboardScreen(),
                              ),
                            );
                          },
                        ),

                        const Spacer(),
                      ],
                    ),

                    const SizedBox(height: 12),
                    AdventureCard(
  adventure: adventure,
),

const SizedBox(height: 12),

                                        const SectionTitle(
                      title: "Today's Tasks",
                      icon: Icons.check_circle,
                    ),

                    const SizedBox(height: 16),

                    if (tasks.isEmpty)
                      const Center(
  child: Text("No Tasks Available"),
)
                    else
                      ...tasks.map(
                        (task) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(
                              bottom: 12,
                            ),
                            child: TaskCard(
                              task: task,
                             onComplete: () async {
  final previousLevel =
      LevelHelper.getLevel(
    child.xp,
  );

  final success =
      await _taskService.completeTask(task);

  if (!mounted ||
      !success) {
    return;
  }

  await CelebrationService.showSuccess(
    context: context,
    message:
        "${task.title} completed! +${task.xp} XP",
  );

  if (!mounted) return;

  final updatedChild =
      await _childService
          .getChild(
            widget.childId,
          )
          .first;

  if (!mounted) return;

  final newLevel =
      LevelHelper.getLevel(
    updatedChild.xp,
  );

  if (newLevel >
      previousLevel) {
    await showDialog(
      context: context,
      builder: (_) =>
          LevelUpDialog(
        level: newLevel,
      ),
    );
  }
},
                            ),
                          );
                        },
                      ),
                                        ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}