import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnalyticsService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getAnalytics() async {
    final parentId =
        FirebaseAuth.instance.currentUser!.uid;

    final childrenSnapshot =
        await _firestore
            .collection("children")
            .where(
              "parentId",
              isEqualTo: parentId,
            )
            .get();

    final children = childrenSnapshot.docs;

    int totalChildren = children.length;
    int totalXP = 0;
    int totalCoins = 0;
    int completedTasks = 0;
    int pendingTasks = 0;

    String topChild = "-";
    int highestXP = -1;

    for (final child in children) {
      final data = child.data();

      final int xp =
          (data["xp"] ?? 0).toInt();

      final int coins =
          (data["coins"] ?? 0).toInt();

      totalXP += xp;
      totalCoins += coins;

      if (xp > highestXP) {
        highestXP = xp;
        topChild = data["name"] ?? "-";
      }

      final taskSnapshot =
          await _firestore
              .collection("tasks")
              .where(
                "childId",
                isEqualTo: child.id,
              )
              .get();

      for (final task in taskSnapshot.docs) {
        if (task["isCompleted"] == true) {
          completedTasks++;
        } else {
          pendingTasks++;
        }
      }
    }

    final rewards =
        await _firestore
            .collection("rewards")
            .where(
              "parentId",
              isEqualTo: parentId,
            )
            .get();

    final totalTasks =
        completedTasks + pendingTasks;

    final completionRate =
        totalTasks == 0
            ? 0.0
            : completedTasks /
                totalTasks;

    return {
      "children": totalChildren,
      "xp": totalXP,
      "coins": totalCoins,
      "completedTasks":
          completedTasks,
      "pendingTasks":
          pendingTasks,
      "totalTasks": totalTasks,
      "completionRate":
          completionRate,
      "topChild": topChild,
      "rewards":
          rewards.docs.length,
    };
  }
}