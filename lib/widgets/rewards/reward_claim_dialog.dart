import 'package:flutter/material.dart';

import 'package:kidquest/models/login_reward.dart';

class RewardClaimDialog extends StatelessWidget {
  final LoginReward reward;

  const RewardClaimDialog({
    super.key,
    required this.reward,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            const Icon(
              Icons.workspace_premium,
              color: Colors.amber,
              size: 90,
            ),

            const SizedBox(height: 20),

            const Text(
              "Congratulations!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              reward.isChest
                  ? "Epic Chest Unlocked!"
                  : "Daily Reward Claimed",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            if (reward.coins > 0)
              Container(
                margin: const EdgeInsets.only(
                  bottom: 12,
                ),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius:
                      BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.monetization_on,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "+${reward.coins} Coins",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

            if (reward.xp > 0)
              Container(
                margin: const EdgeInsets.only(
                  bottom: 12,
                ),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius:
                      BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "+${reward.xp} XP",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.deepPurple,
                  foregroundColor:
                      Colors.white,
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(18),
                  ),
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  "AWESOME!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}