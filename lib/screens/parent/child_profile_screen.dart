import 'package:flutter/material.dart';
import 'package:kidquest/models/child.dart';
import 'package:kidquest/screens/parent/analytics_screen.dart';
import 'package:kidquest/utils/level_helper.dart';

class ChildProfileScreen extends StatelessWidget {
  final Child child;

  const ChildProfileScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final level = LevelHelper.getLevel(child.xp);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Child Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.blue.shade100,
              child: const Icon(
                Icons.child_care,
                size: 60,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              child.name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.cake),
                      title: const Text("Age"),
                      trailing: Text("${child.age}"),
                    ),

                    const Divider(),

                    ListTile(
                      leading: const Icon(Icons.star),
                      title: const Text("Total XP"),
                      trailing: Text("${child.xp}"),
                    ),

                    const Divider(),

                    ListTile(
                      leading: const Icon(
                        Icons.local_fire_department,
                        color: Colors.orange,
                      ),
                      title: const Text("Daily Streak"),
                      trailing: Text(
                        "${child.streak} day${child.streak == 1 ? '' : 's'}",
                      ),
                    ),

                    const Divider(),

                    ListTile(
                      leading: const Icon(Icons.emoji_events),
                      title: const Text("Level"),
                      trailing: Text("Level $level"),
                    ),

                    const Divider(),

                    ListTile(
                      leading: const Icon(Icons.badge),
                      title: const Text("Child Code"),
                      trailing: SelectableText(child.childCode),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.analytics),
                label: const Text(
                  "View Family Analytics",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AnalyticsScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}