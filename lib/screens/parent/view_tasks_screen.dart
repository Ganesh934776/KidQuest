import 'package:flutter/material.dart';
import 'package:kidquest/models/task.dart';
import 'package:kidquest/screens/parent/edit_task_screen.dart';
import 'package:kidquest/services/task_service.dart';

class ViewTasksScreen extends StatelessWidget {
  ViewTasksScreen({super.key});

  final TaskService _taskService = TaskService();

  Future<void> _deleteTask(
    BuildContext context,
    Task task,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Task"),
        content: Text(
          "Delete '${task.title}'?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    await _taskService.deleteTask(task.id);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Task deleted successfully."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assigned Tasks"),
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

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No tasks assigned yet.",
              ),
            );
          }

          final tasks = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: tasks.length,
            itemBuilder: (_, index) {
              final task = tasks[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 4,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: task.isCompleted
                        ? Colors.green
                        : Colors.orange,
                    child: Icon(
                      task.isCompleted
                          ? Icons.check
                          : Icons.assignment,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(task.title),
                  subtitle: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(task.description),
                      const SizedBox(height: 5),
                      Text("⭐ ${task.xp} XP"),
                      Text("⏰ ${task.deadline}"),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  EditTaskScreen(
                                task: task,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () =>
                            _deleteTask(
                          context,
                          task,
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