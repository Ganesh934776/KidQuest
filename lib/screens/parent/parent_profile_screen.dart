import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kidquest/models/child.dart';
import 'package:kidquest/services/child_service.dart';

class ParentProfileScreen extends StatelessWidget {
  const ParentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final childService = ChildService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Parent Profile"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Child>>(
        stream: childService.getChildren(user.uid),
        builder: (context, snapshot) {
          final children = snapshot.data ?? [];

          int totalXP = 0;

          for (final child in children) {
            totalXP += child.xp;
          }

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const CircleAvatar(
                radius: 55,
                child: Icon(
                  Icons.family_restroom,
                  size: 60,
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: Text(
                  user.email ?? "",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.people),
                  title: const Text("Children"),
                  trailing: Text(
                    children.length.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.star),
                  title: const Text("Total Family XP"),
                  trailing: Text(
                    "$totalXP XP",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(55),
                ),
                icon: const Icon(Icons.logout),
                label: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();

                  if (!context.mounted) return;

                  Navigator.popUntil(
                    context,
                    (route) => route.isFirst,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}