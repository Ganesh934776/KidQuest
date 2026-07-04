import 'package:flutter/material.dart';
import 'package:kidquest/widgets/animations/level_up_dialog.dart';
import 'package:kidquest/models/child.dart';
import 'package:kidquest/models/task.dart';
import 'package:kidquest/screens/child/achievements_screen.dart';
import 'package:kidquest/screens/child/reward_store_screen.dart';
import 'package:kidquest/services/celebration_service.dart';
import 'package:kidquest/services/child_service.dart';
import 'package:kidquest/services/task_service.dart';
import 'package:kidquest/utils/level_helper.dart';
import 'package:kidquest/widgets/task_card.dart';

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
  final TaskService _taskService = TaskService();
  final ChildService _childService = ChildService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Child Dashboard"),
        centerTitle: true,
      ),
      body: StreamBuilder<Child>(
        stream: _childService.getChild(widget.childId),
        builder: (context, childSnapshot) {
          if (childSnapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (childSnapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${childSnapshot.error}",
              ),
            );
          }

          if (!childSnapshot.hasData) {
            return const Center(
              child: Text("Child not found"),
            );
          }

          final child = childSnapshot.data!;

          final xp = child.xp;
          final coins = child.coins;
          final streak = child.streak;

          final level = LevelHelper.getLevel(xp);
          final nextXP =
              LevelHelper.nextLevelXP(level);

          final progress =
              LevelHelper.progress(xp);

          return StreamBuilder<List<Task>>(
            stream: _taskService.getTasksForChild(
              widget.childId,
            ),
            builder: (context, taskSnapshot) {
              if (taskSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child:
                      CircularProgressIndicator(),
                );
              }

              if (taskSnapshot.hasError) {
                return Center(
                  child: Text(
                    "Error: ${taskSnapshot.error}",
                  ),
                );
              }

              final tasks =
                  taskSnapshot.data ?? [];

              return Padding(
                padding:
                    const EdgeInsets.all(16),
                child: Column(
                  children: [                    /// LEVEL CARD
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.emoji_events,
                              size: 55,
                              color: Colors.amber,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Level $level",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 18),
                            LinearProgressIndicator(
                              value: progress,
                              minHeight: 12,
                              borderRadius:
                                  BorderRadius.circular(20),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "$xp / $nextXP XP",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${nextXP - xp} XP until Level ${level + 1}",
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// STREAK CARD
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.orange,
                              child: Icon(
                                Icons.local_fire_department,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Daily Streak",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "$streak Day${streak == 1 ? '' : 's'}",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight:
                                          FontWeight.bold,
                                      color:
                                          Colors.deepOrange,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    streak == 0
                                        ? "Complete a task today to begin!"
                                        : "Keep your streak alive 🔥",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),
                    Card(
  elevation: 5,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18),
  ),
  child: Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 18,
    ),
    child: Row(
      children: [
        const CircleAvatar(
          radius: 28,
          backgroundColor: Colors.amber,
          child: Icon(
            Icons.monetization_on,
            color: Colors.white,
            size: 30,
          ),
        ),

        const SizedBox(width: 18),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                "Coins",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                "$coins Coins",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                "Earn coins by completing tasks!",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
),

const SizedBox(height: 18),

                    /// REWARD STORE
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.card_giftcard,
                        ),
                        label: const Text(
                          "Reward Store",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  RewardStoreScreen(
                                childId:
                                    widget.childId,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// ACHIEVEMENTS
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: OutlinedButton.icon(
                        icon: const Icon(
                          Icons.emoji_events,
                        ),
                        label: const Text(
                          "Achievements",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  AchievementsScreen(
                                childId:
                                    widget.childId,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 22),

                    const Align(
                      alignment:
                          Alignment.centerLeft,
                      child: Text(
                        "Today's Tasks",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Expanded(
                      child: tasks.isEmpty
                          ? const Center(
                              child: Text(
                                "No tasks assigned.",
                              ),
                            )
                          : ListView.builder(
                              itemCount: tasks.length,
                              itemBuilder:
                                  (context, index) {
                                final task =
                                    tasks[index]; 
                                    final previousLevel = LevelHelper.getLevel(child.xp);                               return TaskCard(
                                  task: task,
                                  onComplete: () async {
  if (!mounted) return;

  final screenContext = context;

  final success =
      await _taskService.completeTask(task);

  if (!screenContext.mounted) return;

  if (!success) return;

  await CelebrationService.showSuccess(
    context: screenContext,
    message:
        "${task.title} completed! +${task.xp} XP",
  );

  // Reload the child's latest data
  final latestChild = await _childService
      .getChild(widget.childId)
      .first;

  final newLevel =
      LevelHelper.getLevel(latestChild.xp);

  if (!screenContext.mounted) return;

  if (newLevel > previousLevel) {
    await showDialog(
      context: screenContext,
      builder: (_) => LevelUpDialog(
        level: newLevel,
      ),
    );
  }
},
                                );
                              },
                            ),
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