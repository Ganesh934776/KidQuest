import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class DailyRewardService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  /// Check if today's reward has already been claimed
  Future<bool> canClaim(String childId) async {
    final today =
        DateTime.now().toIso8601String().substring(0, 10);

    final snapshot = await _firestore
        .collection("daily_rewards")
        .where("childId", isEqualTo: childId)
        .where("claimedDate", isEqualTo: today)
        .limit(1)
        .get();

    return snapshot.docs.isEmpty;
  }

  /// Claim Daily Reward
  Future<Map<String, dynamic>> claimReward(
    String childId,
  ) async {
    final random = Random();

    final rewards = [
      {
        "type": "Coins",
        "value": 50,
      },
      {
        "type": "Coins",
        "value": 100,
      },
      {
        "type": "Coins",
        "value": 150,
      },
      {
        "type": "XP",
        "value": 40,
      },
      {
        "type": "XP",
        "value": 80,
      },
      {
        "type": "XP",
        "value": 120,
      },
    ];

    final reward =
        rewards[random.nextInt(rewards.length)];

    final childRef =
        _firestore.collection("children").doc(childId);

    final today =
        DateTime.now().toIso8601String().substring(0, 10);

    await _firestore.runTransaction(
      (transaction) async {
        final childSnapshot =
            await transaction.get(childRef);

        if (!childSnapshot.exists) {
          throw Exception("Child not found");
        }

        final data = childSnapshot.data()!;

        int xp = data["xp"] ?? 0;
        int coins = data["coins"] ?? 0;

        if (reward["type"] == "XP") {
          xp += reward["value"] as int;
        } else {
          coins += reward["value"] as int;
        }

        transaction.update(childRef, {
          "xp": xp,
          "coins": coins,
        });

        final rewardRef =
            _firestore.collection("daily_rewards").doc();

        transaction.set(
          rewardRef,
          {
            "childId": childId,
            "claimedDate": today,
            "rewardType": reward["type"],
            "rewardValue": reward["value"],
            "claimedAt": Timestamp.now(),
          },
        );
      },
    );

    return reward;
  }

  /// Get reward history
  Stream<QuerySnapshot<Map<String, dynamic>>> getRewardHistory(
    String childId,
  ) {
    return _firestore
        .collection("daily_rewards")
        .where("childId", isEqualTo: childId)
        .orderBy("claimedAt", descending: true)
        .snapshots();
  }
}