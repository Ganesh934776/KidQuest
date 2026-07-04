import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RedeemedRewardsScreen extends StatelessWidget {
  const RedeemedRewardsScreen({super.key});

  Future<String> _getChildName(String childId) async {
    final doc = await FirebaseFirestore.instance
        .collection('children')
        .doc(childId)
        .get();

    if (!doc.exists) return "Unknown Child";

    return doc.data()?['name'] ?? "Unknown Child";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Redeemed Rewards"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('redeemed_rewards')
            .orderBy('redeemedAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No rewards redeemed yet.",
              ),
            );
          }

          final redeemed = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: redeemed.length,
            itemBuilder: (context, index) {
              final reward =
                  redeemed[index].data()
                      as Map<String, dynamic>;

              final date =
                  (reward['redeemedAt'] as Timestamp)
                      .toDate();

              return FutureBuilder<String>(
                future: _getChildName(
                  reward['childId'],
                ),
                builder: (context, childSnapshot) {
                  final childName =
                      childSnapshot.data ??
                          "Loading...";

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(
                          Icons.card_giftcard,
                        ),
                      ),
                      title: Text(
                        reward['rewardTitle'],
                      ),
                      subtitle: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text("👦 $childName"),
                          Text(
                              "⭐ ${reward['xpCost']} XP"),
                          Text(
                            "${date.day}/${date.month}/${date.year}",
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}