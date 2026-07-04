import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kidquest/models/reward.dart';
import 'package:kidquest/screens/parent/edit_reward_screen.dart';
import 'package:kidquest/services/reward_service.dart';

class ViewRewardsScreen extends StatelessWidget {
  ViewRewardsScreen({super.key});

  final RewardService _rewardService =
      RewardService();

  Future<void> _deleteReward(
    BuildContext context,
    Reward reward,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Reward"),
        content: Text(
          "Are you sure you want to delete '${reward.title}'?",
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () =>
                Navigator.pop(context, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    await _rewardService.deleteReward(reward.id);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Reward deleted successfully.",
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final parentId =
        FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Rewards"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Reward>>(
        stream:
            _rewardService.getRewards(parentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No rewards created yet.",
              ),
            );
          }

          final rewards = snapshot.data!;

          return ListView.builder(
            padding:
                const EdgeInsets.all(12),
            itemCount: rewards.length,
            itemBuilder: (_, index) {
              final reward = rewards[index];

              return Card(
                elevation: 4,
                margin:
                    const EdgeInsets.only(
                  bottom: 12,
                ),
                child: ListTile(
                  leading:
                      const CircleAvatar(
                    backgroundColor:
                        Colors.orange,
                    child: Icon(
                      Icons.card_giftcard,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    reward.title,
                  ),
                  subtitle: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Text(
                        reward.description,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "🪙 ${reward.coinCost} Coins",
                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          color:
                              Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color:
                              Colors.blue,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  EditRewardScreen(
                                reward:
                                    reward,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color:
                              Colors.red,
                        ),
                        onPressed: () =>
                            _deleteReward(
                          context,
                          reward,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}