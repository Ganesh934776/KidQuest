import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kidquest/models/reward.dart';
import 'package:kidquest/services/celebration_service.dart';
import 'package:kidquest/services/reward_service.dart';

class RewardStoreScreen extends StatefulWidget {
  final String childId;

  const RewardStoreScreen({
    super.key,
    required this.childId,
  });

  @override
  State<RewardStoreScreen> createState() =>
      _RewardStoreScreenState();
}

class _RewardStoreScreenState
    extends State<RewardStoreScreen> {
  int _coins = 0;
  bool _loadingCoins = true;

  @override
  void initState() {
    super.initState();
    _loadCoins();
  }

  Future<void> _loadCoins() async {
    final doc = await FirebaseFirestore.instance
        .collection('children')
        .doc(widget.childId)
        .get();

    if (!mounted) return;

    setState(() {
      _coins = doc.data()?['coins'] ?? 0;
      _loadingCoins = false;
    });
  }

  Future<void> _redeemReward(
    Reward reward,
  ) async {
    final success =
        await RewardService().redeemReward(
      childId: widget.childId,
      reward: reward,
    );

    if (!mounted) return;

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Not enough coins!"),
        ),
      );
      return;
    }

    await CelebrationService.showSuccess(
      context: context,
      message: "Reward Redeemed!",
      icon: Icons.card_giftcard,
      color: Colors.orange,
    );

    await _loadCoins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reward Store"),
        centerTitle: true,
      ),
      body: _loadingCoins
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : Column(
              children: [
                Card(
                  margin:
                      const EdgeInsets.all(16),
                  elevation: 5,
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor:
                          Colors.amber,
                      child: Icon(
                        Icons
                            .monetization_on,
                        color: Colors.white,
                      ),
                    ),
                    title: const Text(
                      "Your Coins",
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "$_coins Coins",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight:
                            FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child:
                      StreamBuilder<List<Reward>>(
                    stream: RewardService()
                        .getAvailableRewards(),
                    builder:
                        (context, snapshot) {
                      if (snapshot
                              .connectionState ==
                          ConnectionState
                              .waiting) {
                        return const Center(
                          child:
                              CircularProgressIndicator(),
                        );
                      }

                      if (!snapshot.hasData ||
                          snapshot
                              .data!.isEmpty) {
                        return const Center(
                          child: Text(
                            "No rewards available.",
                          ),
                        );
                      }

                      final rewards =
                          snapshot.data!;

                      return ListView.builder(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemCount:
                            rewards.length,
                        itemBuilder:
                            (context, index) {
                          final reward =
                              rewards[index];

                          final canRedeem =
                              _coins >=
                                  reward
                                      .coinCost;

                          return Card(
                            elevation: 4,
                            margin:
                                const EdgeInsets
                                    .only(
                              bottom: 14,
                            ),
                            child: ListTile(
                              leading:
                                  CircleAvatar(
                                backgroundColor:
                                    canRedeem
                                        ? Colors
                                            .green
                                        : Colors
                                            .grey,
                                child: const Icon(
                                  Icons
                                      .card_giftcard,
                                  color: Colors
                                      .white,
                                ),
                              ),
                              title: Text(
                                reward.title,
                                style:
                                    const TextStyle(
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [
                                  const SizedBox(
                                      height:
                                          4),
                                  Text(
                                    reward
                                        .description,
                                  ),
                                  const SizedBox(
                                      height:
                                          8),
                                  Text(
                                    "🪙 ${reward.coinCost} Coins",
                                    style:
                                        const TextStyle(
                                      color: Colors
                                          .orange,
                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                                  ),
                                ],
                              ),
                              trailing:
                                  ElevatedButton(
                                onPressed:
                                    canRedeem
                                        ? () =>
                                            _redeemReward(
                                              reward,
                                            )
                                        : null,
                                child: Text(
                                  canRedeem
                                      ? "Redeem"
                                      : "Locked",
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}