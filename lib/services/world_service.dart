import 'package:kidquest/models/world.dart';

class WorldService {
  static World generate({
    required int completedTasks,
    required int streak,
    required int level,
  }) {
    return World.fromProgress(
      completedTasks: completedTasks,
      streak: streak,
      level: level,
    );
  }
}