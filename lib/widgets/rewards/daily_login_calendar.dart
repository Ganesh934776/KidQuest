import 'package:flutter/material.dart';

import 'package:kidquest/models/login_reward.dart';
import 'package:kidquest/services/login_reward_service.dart';
import 'package:kidquest/widgets/rewards/login_reward_tile.dart';
import 'package:kidquest/widgets/rewards/reward_claim_dialog.dart';

class DailyLoginCalendar extends StatefulWidget {
  final String childId;

  const DailyLoginCalendar({
    super.key,
    required this.childId,
  });

  @override
  State<DailyLoginCalendar> createState() =>
      _DailyLoginCalendarState();
}

class _DailyLoginCalendarState
    extends State<DailyLoginCalendar> {
  int currentDay = 1;

  bool loading = true;

  bool canClaim = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    currentDay =
        await LoginRewardService.currentDay(
      widget.childId,
    );

    canClaim =
        await LoginRewardService.canClaimToday(
      widget.childId,
    );

    if (!mounted) return;

    setState(() {
      loading = false;
    });
  }

  Future<void> _claimReward() async {
    final LoginReward? reward =
        await LoginRewardService.claimReward(
      widget.childId,
    );

    if (!mounted) return;

    if (reward == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Today's reward already claimed!",
          ),
        ),
      );
      return;
    }

    await showDialog(
  context: context,
  barrierDismissible: false,
  builder: (_) => RewardClaimDialog(
    reward: reward,
  ),
);

    await _load();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final rewards =
        LoginRewardService.rewards;

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          "🎁 Daily Login Rewards",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 18),

        SizedBox(
          height: 170,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: rewards.length,
            separatorBuilder: (_, __) =>
                const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final reward = rewards[index];

              final claimed =
                  reward.day < currentDay;

              final today =
                  reward.day == currentDay;

              final locked =
                  reward.day > currentDay;

              return LoginRewardTile(
                reward: reward,
                claimed: claimed,
                today: today,
                locked: locked,
                onTap: today && canClaim
                    ? _claimReward
                    : null,
              );
            },
          ),
        ),
      ],
    );
  }
}