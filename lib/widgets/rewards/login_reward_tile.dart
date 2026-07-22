import 'package:flutter/material.dart';

import 'package:kidquest/models/login_reward.dart';

class LoginRewardTile extends StatelessWidget {
  final LoginReward reward;
  final bool claimed;
  final bool today;
  final bool locked;
  final VoidCallback? onTap;

  const LoginRewardTile({
    super.key,
    required this.reward,
    required this.claimed,
    required this.today,
    required this.locked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color background;

    if (claimed) {
      background = Colors.green;
    } else if (today) {
      background = reward.color;
    } else if (locked) {
      background = Colors.grey.shade300;
    } else {
      background = Colors.white;
    }

    return GestureDetector(
      onTap: locked || claimed ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        width: 100,
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: today
                ? Colors.orange
                : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: background.withValues(alpha: 0.30),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "DAY ${reward.day}",
              style: TextStyle(
                color: claimed || today
                    ? Colors.white
                    : Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 8),

            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white.withValues(alpha: 0.95),
              child: Icon(
                claimed
                    ? Icons.check
                    : locked
                        ? Icons.lock
                        : reward.icon,
                color: claimed
                    ? Colors.green
                    : locked
                        ? Colors.grey
                        : reward.color,
                size: 24,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              reward.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: claimed || today
                    ? Colors.white
                    : Colors.black87,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 6),

            if (today && !claimed)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "CLAIM",
                  style: TextStyle(
                    color: reward.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),

            if (claimed)
              const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Icon(
                  Icons.verified,
                  color: Colors.white,
                  size: 18,
                ),
              ),
          ],
        ),
      ),
    );
  }
}