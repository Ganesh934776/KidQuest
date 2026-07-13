import 'package:flutter/material.dart';
import 'package:kidquest/models/child.dart';
import 'package:kidquest/services/child_service.dart';
import 'package:kidquest/utils/level_helper.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Leaderboard"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Child>>(
        stream: ChildService().getLeaderboard(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final children = snapshot.data!;

          if (children.isEmpty) {
            return const Center(
              child: Text(
                "No children found.",
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: children.length,
            itemBuilder: (context, index) {
              final child = children[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 14),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundColor: _medalColor(index),
                    child: Text(
                      "#${index + 1}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    child.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Level ${LevelHelper.getLevel(child.xp)}",
                  ),
                  trailing: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      Text("${child.xp} XP"),
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

  Color _medalColor(int rank) {
    switch (rank) {
      case 0:
        return Colors.amber;
      case 1:
        return Colors.grey;
      case 2:
        return Colors.brown;
      default:
        return Colors.blue;
    }
  }
}