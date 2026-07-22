import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:kidquest/models/login_reward.dart';

class LoginRewardService {
  LoginRewardService._();

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  // ==========================================================
  // WEEKLY REWARDS
  // ==========================================================

  static const List<LoginReward> rewards = [
    LoginReward(
      day: 1,
      coins: 50,
      xp: 0,
    ),
    LoginReward(
      day: 2,
      coins: 0,
      xp: 40,
    ),
    LoginReward(
      day: 3,
      coins: 80,
      xp: 0,
    ),
    LoginReward(
      day: 4,
      coins: 0,
      xp: 60,
    ),
    LoginReward(
      day: 5,
      coins: 120,
      xp: 0,
    ),
    LoginReward(
      day: 6,
      coins: 0,
      xp: 100,
    ),
    LoginReward(
      day: 7,
      coins: 300,
      xp: 200,
      isChest: true,
    ),
  ];

  // ==========================================================
  // GET LOGIN DATA
  // ==========================================================

  static Future<Map<String, dynamic>> getLoginData(
    String childId,
  ) async {
    final doc = await _firestore
        .collection("children")
        .doc(childId)
        .get();

    final data = doc.data() ?? {};

    return {
      "loginDay": data["loginDay"] ?? 1,
      "lastLoginReward":
          data["lastLoginReward"] as Timestamp?,
    };
  }

  // ==========================================================
  // CAN CLAIM TODAY?
  // ==========================================================

  static Future<bool> canClaimToday(
    String childId,
  ) async {
    final data =
        await getLoginData(childId);

    final Timestamp? last =
        data["lastLoginReward"];

    if (last == null) {
      return true;
    }

    final lastDate = last.toDate();

    final today = DateTime.now();

    return lastDate.year != today.year ||
        lastDate.month != today.month ||
        lastDate.day != today.day;
  }

  // ==========================================================
  // CLAIM TODAY'S REWARD
  // ==========================================================

  static Future<LoginReward?> claimReward(
    String childId,
  ) async {
    final canClaim =
        await canClaimToday(childId);

    if (!canClaim) {
      return null;
    }

    final childRef = _firestore
        .collection("children")
        .doc(childId);

    final snapshot =
        await childRef.get();

    final data = snapshot.data()!;

    int loginDay =
        data["loginDay"] ?? 1;

    if (loginDay > 7) {
      loginDay = 1;
    }

    final reward =
        rewards[loginDay - 1];

    final currentCoins =
        data["coins"] ?? 0;

    final currentXP =
        data["xp"] ?? 0;

    await childRef.update({
      "coins":
          currentCoins + reward.coins,
      "xp":
          currentXP + reward.xp,
      "loginDay":
          loginDay == 7 ? 1 : loginDay + 1,
      "lastLoginReward":
          Timestamp.now(),
    });

    return reward;
  }

  // ==========================================================
  // CURRENT DAY
  // ==========================================================

  static Future<int> currentDay(
    String childId,
  ) async {
    final data =
        await getLoginData(childId);

    return data["loginDay"];
  }
}