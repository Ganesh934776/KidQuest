import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kidquest/services/achievement_service.dart';

class AchievementsScreen extends StatelessWidget {
  final String childId;

  const AchievementsScreen({
    super.key,
    required this.childId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Achievements"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: AchievementService().getAchievements(childId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No achievements unlocked yet!",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final achievements = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: achievements.length,
            itemBuilder: (context, index) {
              final achievement = achievements[index].data();

              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Text(
                    achievement['icon'] ?? "🏆",
                    style: const TextStyle(fontSize: 30),
                  ),
                  title: Text(
                    achievement['title'] ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    achievement['description'] ?? "",
                  ),
                  trailing: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
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