import 'package:flutter/material.dart';

import '../../models/reward.dart';
import 'redeem_button.dart';

class RewardCard extends StatelessWidget {
  final Reward reward;
  final int coins;
  final VoidCallback onRedeem;

  const RewardCard({
    super.key,
    required this.reward,
    required this.coins,
    required this.onRedeem,
  });

  @override
  Widget build(BuildContext context) {
    final canRedeem = coins >= reward.coinCost;

    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                CircleAvatar(
                  radius: 30,
                  backgroundColor:
                      Colors.orange.shade100,
                  child: const Icon(
                    Icons.card_giftcard,
                    size: 34,
                    color: Colors.orange,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      Text(
                        reward.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        reward.description,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius:
                    BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  const Icon(
                    Icons.monetization_on,
                    color: Colors.orange,
                  ),

                  const SizedBox(width: 6),

                  Text(
                    "${reward.coinCost} Coins",
                    style: const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            RedeemButton(
              enabled: canRedeem,
              onPressed: onRedeem,
            ),
          ],
        ),
      ),
    );
  }
}