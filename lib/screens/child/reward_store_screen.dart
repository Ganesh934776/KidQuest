import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kidquest/models/reward.dart';
import 'package:kidquest/services/celebration_service.dart';
import 'package:kidquest/services/reward_service.dart';

class RewardStoreScreen extends StatelessWidget {
  final String childId;

  const RewardStoreScreen({
    super.key,
    required this.childId,
  });

  Future<int> _getChildCoins() async {
    final doc = await FirebaseFirestore.instance
        .collection('children')
        .doc(childId)
        .get();

    return doc.data()?['coins'] ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reward Store"),
        centerTitle: true,
      ),
      body: FutureBuilder<int>(
        future: _getChildCoins(),
        builder: (context, coinSnapshot) {
          if (coinSnapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!coinSnapshot.hasData) {
            return const Center(
              child: Text("Unable to load coins"),
            );
          }

          final childCoins = coinSnapshot.data!;

          return Column(
            children: [
              Card(
                margin: const EdgeInsets.all(16),
                elevation: 5,
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.amber,
                    child: Icon(
                      Icons.monetization_on,
                      color: Colors.white,
                    ),
                  ),
                  title: const Text(
                    "Your Coins",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "$childCoins Coins",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: StreamBuilder<List<Reward>>(
                  stream: RewardService()
                      .getAvailableRewards(),
                  builder: (context, rewardSnapshot) {
                    if (rewardSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child:
                            CircularProgressIndicator(),
                      );
                    }

                    if (!rewardSnapshot.hasData ||
                        rewardSnapshot.data!.isEmpty) {
                      return const Center(
                        child: Text(
                          "No rewards available.",
                        ),
                      );
                    }

                    final rewards =
                        rewardSnapshot.data!;

                    return ListView.builder(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      itemCount: rewards.length,
                      itemBuilder: (_, index) {
                        final reward =
                            rewards[index];

                        final canRedeem =
                            childCoins >=
                                reward.coinCost;

                        return Card(
                          child: ListTile(
                            leading:
                                const CircleAvatar(
                              child: Icon(
                                Icons.card_giftcard,
                              ),
                            ),
                            title:
                                Text(reward.title),
                            subtitle: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [
                                Text(
                                  reward.description,
                                ),
                                const SizedBox(
                                    height: 6),
                                Text(
                                  "Cost: ${reward.coinCost} Coins",
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
                            trailing:
                                ElevatedButton(
                              onPressed:
                                  canRedeem
                                      ? () async {
                                          final success =
                                              await RewardService()
                                                  .redeemReward(
                                            childId:
                                                childId,
                                            reward:
                                                reward,
                                          );

                                          if (!context
                                              .mounted) {
                                            return;
                                          }

                                          if (success) {
                                           if (!context.mounted) return;

                                          await CelebrationService.showSuccess(
  context: context,
  message: "Reward Redeemed!",
  icon: Icons.card_giftcard,
  color: Colors.orange,
);

if (!context.mounted) return;

Navigator.pop(context); 
                                          } else {
                                            ScaffoldMessenger.of(
                                                    context)
                                                .showSnackBar(
                                              const SnackBar(
                                                backgroundColor:
                                                    Colors.red,
                                                content:
                                                    Text(
                                                  "Not enough coins!",
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      : null,
                              child: const Text(
                                  "Redeem"),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}