import 'package:cloud_firestore/cloud_firestore.dart';

class AchievementService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> unlockAchievement({
    required String childId,
    required String achievementId,
    required String title,
    required String description,
    required String icon,
  }) async {
    final achievementRef = _firestore
        .collection('children')
        .doc(childId)
        .collection('achievements')
        .doc(achievementId);

    final doc = await achievementRef.get();

    if (doc.exists) {
      return;
    }

    await achievementRef.set({
      'title': title,
      'description': description,
      'icon': icon,
      'unlocked': true,
      'unlockedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> checkAchievements({
    required String childId,
    required int xp,
    required int completedTasks,
  }) async {
    if (completedTasks >= 1) {
      await unlockAchievement(
        childId: childId,
        achievementId: 'first_task',
        title: 'First Steps',
        description: 'Completed your first task',
        icon: '🎉',
      );
    }

    if (completedTasks >= 10) {
      await unlockAchievement(
        childId: childId,
        achievementId: 'task_master',
        title: 'Task Master',
        description: 'Completed 10 tasks',
        icon: '🔥',
      );
    }

    if (xp >= 100) {
      await unlockAchievement(
        childId: childId,
        achievementId: 'xp_collector',
        title: 'XP Collector',
        description: 'Earned 100 XP',
        icon: '⭐',
      );
    }

    if (xp >= 500) {
      await unlockAchievement(
        childId: childId,
        achievementId: 'rising_star',
        title: 'Rising Star',
        description: 'Earned 500 XP',
        icon: '🏆',
      );
    }

    if (xp >= 1000) {
      await unlockAchievement(
        childId: childId,
        achievementId: 'legend',
        title: 'Legend',
        description: 'Reached 1000 XP',
        icon: '👑',
      );
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAchievements(
    String childId,
  ) {
    return _firestore
        .collection('children')
        .doc(childId)
        .collection('achievements')
        .orderBy('unlockedAt', descending: true)
        .snapshots();
  }

  /// Returns the most recently unlocked achievement.
  Future<Map<String, dynamic>?> getLatestAchievement(
    String childId,
  ) async {
    final snapshot = await _firestore
        .collection('children')
        .doc(childId)
        .collection('achievements')
        .orderBy('unlockedAt', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return snapshot.docs.first.data();
  }
}