import 'package:flutter/material.dart';

class LoginReward {
  final int day;
  final int coins;
  final int xp;
  final bool isChest;

  const LoginReward({
    required this.day,
    required this.coins,
    required this.xp,
    this.isChest = false,
  });

  String get title {
    if (isChest) {
      return "Epic Chest";
    }

    if (coins > 0) {
      return "$coins Coins";
    }

    return "$xp XP";
  }

  IconData get icon {
    if (isChest) {
      return Icons.workspace_premium;
    }

    if (coins > 0) {
      return Icons.monetization_on;
    }

    return Icons.star;
  }

  Color get color {
    if (isChest) {
      return Colors.deepPurple;
    }

    if (coins > 0) {
      return Colors.amber;
    }

    return Colors.orange;
  }
}