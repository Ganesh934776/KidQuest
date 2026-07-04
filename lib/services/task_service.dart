import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kidquest/models/task.dart';
import 'package:kidquest/services/achievement_service.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AchievementService _achievementService =
      AchievementService();

  Future<void> addTask(Task task) async {
    final doc = _firestore.collection('tasks').doc();

    final newTask = Task(
      id: doc.id,
      title: task.title,
      description: task.description,
      xp: task.xp,
      deadline: task.deadline,
      childId: task.childId,
      isCompleted: false,
    );

    await doc.set(newTask.toMap());
  }

  Stream<List<Task>> getTasksForChild(String childId) {
    return _firestore
        .collection('tasks')
        .where('childId', isEqualTo: childId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Task.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  Stream<List<Task>> getAllTasks() {
    return _firestore
        .collection('tasks')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Task.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  Future<bool> completeTask(Task task) async {
    if (task.isCompleted) {
      return false;
    }

    await _firestore.collection('tasks').doc(task.id).update({
      'isCompleted': true,
    });

    final childRef =
        _firestore.collection('children').doc(task.childId);

    int latestXP = 0;

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(childRef);

      final data = snapshot.data()!;

      final currentXP = data['xp'] ?? 0;
      final currentCoins = data['coins'] ?? 0;
      final currentStreak = data['streak'] ?? 0;

      latestXP = currentXP + task.xp;

      final earnedCoins = (task.xp / 5).round();
      final latestCoins = currentCoins + earnedCoins;

      final Timestamp? lastTimestamp =
          data['lastCompletedDate'];

      final now = DateTime.now();

      int newStreak = 1;

      if (lastTimestamp != null) {
        final lastDate = lastTimestamp.toDate();

        final today =
            DateTime(now.year, now.month, now.day);

        final previous = DateTime(
          lastDate.year,
          lastDate.month,
          lastDate.day,
        );

        final difference =
            today.difference(previous).inDays;

        if (difference == 0) {
          newStreak = currentStreak;
        } else if (difference == 1) {
          newStreak = currentStreak + 1;
        } else {
          newStreak = 1;
        }
      }

      transaction.update(childRef, {
        'xp': latestXP,
        'coins': latestCoins,
        'streak': newStreak,
        'lastCompletedDate': Timestamp.fromDate(now),
      });
    });

    final completedTasks = await _firestore
        .collection('tasks')
        .where('childId', isEqualTo: task.childId)
        .where('isCompleted', isEqualTo: true)
        .get();

    await _achievementService.checkAchievements(
      childId: task.childId,
      xp: latestXP,
      completedTasks: completedTasks.docs.length,
    );

    return true;
  }

  Future<void> updateTask(Task task) async {
    await _firestore
        .collection('tasks')
        .doc(task.id)
        .update(task.toMap());
  }

  Future<void> deleteTask(String taskId) async {
    await _firestore
        .collection('tasks')
        .doc(taskId)
        .delete();
  }
}