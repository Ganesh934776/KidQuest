import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kidquest/models/task.dart';
import 'package:kidquest/services/task_service.dart';

class ViewTasksScreen extends StatelessWidget {
  ViewTasksScreen({super.key});

  final TaskService _taskService = TaskService();

  Color _statusColor(Task task) {
    if (task.isCompleted) {
      return Colors.green;
    }
    return Colors.orange;
  }

  String _statusText(Task task) {
    if (task.isCompleted) {
      return "Completed";
    }
    return "Pending";
  }

  IconData _statusIcon(Task task) {
    if (task.isCompleted) {
      return Icons.check_circle;
    }
    return Icons.schedule;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today's Routine Progress"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Task>>(
        stream: _taskService.getAllTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final tasks = snapshot.data ?? [];

          if (tasks.isEmpty) {
            return const Center(
              child: Text(
                "No routine generated yet.",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              return Card(
                elevation: 5,
                margin: const EdgeInsets.only(bottom: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor:
                                _statusColor(task),
                            child: Icon(
                              _statusIcon(task),
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.title,
                                  style:
                                      const TextStyle(
                                    fontSize: 20,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  task.description,
                                  style:
                                      const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 20,
                            color: Colors.deepOrange,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Before ${task.submissionTime}",
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 20,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat(
                              "dd MMM yyyy",
                            ).format(task.dueDate),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  Colors.orange.shade100,
                              borderRadius:
                                  BorderRadius.circular(
                                      20),
                            ),
                            child: Text(
                              "⭐ ${task.xp} XP",
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  Colors.amber.shade100,
                              borderRadius:
                                  BorderRadius.circular(
                                      20),
                            ),
                            child: Text(
                              "🪙 ${task.coins}",
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Align(
                        alignment:
                            Alignment.centerRight,
                        child: Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: _statusColor(task)
                                .withValues(alpha: 0.2),
                            borderRadius:
                                BorderRadius.circular(
                                    25),
                          ),
                          child: Text(
                            _statusText(task),
                            style: TextStyle(
                              color:
                                  _statusColor(task),
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}