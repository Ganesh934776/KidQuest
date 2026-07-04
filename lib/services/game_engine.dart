import 'package:kidquest/models/task.dart';
import 'package:kidquest/services/task_service.dart';

class GameEngine {
  final TaskService _taskService = TaskService();

  Future<void> completeTask(Task task) async {
    await _taskService.completeTask(task);
  }
}