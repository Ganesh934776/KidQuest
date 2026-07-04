import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kidquest/models/child.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leaderboard"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('children')
            .orderBy('xp', descending: true)
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
              child: Text("No children found."),
            );
          }

          final children = snapshot.data!.docs
              .map(
                (doc) => Child.fromMap(
                  doc.id,
                  doc.data() as Map<String, dynamic>,
                ),
              )
              .toList();

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: children.length,
            itemBuilder: (context, index) {
              final child = children[index];

              String medal = "";

              switch (index) {
                case 0:
                  medal = "🥇";
                  break;
                case 1:
                  medal = "🥈";
                  break;
                case 2:
                  medal = "🥉";
                  break;
                default:
                  medal = "${index + 1}.";
              }

              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(medal),
                  ),
                  title: Text(
                    child.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Age: ${child.age}",
                  ),
                  trailing: Chip(
                    label: Text(
                      "${child.xp} XP",
                    ),
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