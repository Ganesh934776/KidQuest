import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kidquest/models/child.dart';
import 'package:kidquest/screens/parent/child_profile_screen.dart';
import 'package:kidquest/services/child_service.dart';
import 'package:kidquest/utils/level_helper.dart';

class MyChildrenScreen extends StatelessWidget {
  const MyChildrenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final parentId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Children"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(
            const Duration(milliseconds: 500),
          );
        },
        child: StreamBuilder<List<Child>>(
          stream: ChildService().getChildren(parentId),
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Something went wrong",
                ),
              );
            }

            final children = snapshot.data ?? [];

            if (children.isEmpty) {
              return ListView(
                physics:
                    const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 150),
                  Icon(
                    Icons.child_care,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "No children added yet",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              );
            }

            return ListView.builder(
              physics:
                  const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              itemCount: children.length,
              itemBuilder: (context, index) {
                final child = children[index];
                final level =
                    LevelHelper.getLevel(child.xp);

                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor:
                          Colors.blue.shade100,
                      child: const Icon(
                        Icons.child_care,
                        size: 30,
                        color: Colors.blue,
                      ),
                    ),
                    title: Text(
                      child.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding:
                          const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            "🎂 Age : ${child.age}",
                          ),

                          const SizedBox(height: 5),

                          Text(
                            "⭐ XP : ${child.xp}",
                          ),

                          const SizedBox(height: 5),

                          Text(
                            "🔥 Streak : ${child.streak} day${child.streak == 1 ? '' : 's'}",
                          ),

                          const SizedBox(height: 5),

                          Text(
                            "🏆 Level : $level",
                          ),

                          const SizedBox(height: 10),

                          Chip(
                            avatar: const Icon(
                              Icons.badge,
                              size: 18,
                            ),
                            label: Text(
                              child.childCode,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ChildProfileScreen(
                            child: child,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}