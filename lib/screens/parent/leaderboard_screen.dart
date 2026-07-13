import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:kidquest/models/child.dart';
import 'package:kidquest/services/child_service.dart';
import 'package:kidquest/theme/app_colors.dart';
import 'package:kidquest/theme/app_text_styles.dart';
import 'package:kidquest/utils/level_helper.dart';

class LeaderboardScreen extends StatelessWidget {
  LeaderboardScreen({super.key});

  final ChildService _childService = ChildService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Leaderboard",
        ),
      ),

      body: StreamBuilder<List<Child>>(
        stream: _childService.getLeaderboard(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          final children = snapshot.data ?? [];

          if (children.isEmpty) {
            return const Center(
              child: Text(
                "No children available.",
              ),
            );
          }

          return Column(
            children: [

              _buildChampionCard(
                children.first,
              ),

              Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.all(18),
                  itemCount: children.length,
                  itemBuilder:
                      (context, index) {

                    return _buildRankCard(
                      children[index],
                      index + 1,
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
  Widget _buildChampionCard(Child child) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [
            Color(0xff4facfe),
            Color(0xff00c6fb),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.workspace_premium,
            color: Colors.amber,
            size: 80,
          )
              .animate()
              .scale(duration: 700.ms)
              .then()
              .shimmer(duration: 1200.ms),

          const SizedBox(height: 16),

          Text(
            "Champion",
            style: AppTextStyles.headline.copyWith(
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 18),

          CircleAvatar(
            radius: 45,
            backgroundColor: Colors.white,
            child: Text(
              child.name[0].toUpperCase(),
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            child.name,
            style: AppTextStyles.title.copyWith(
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "${child.xp} XP",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            children: [
              _infoTile(
                Icons.star,
                "${child.xp}",
                "XP",
              ),
              _infoTile(
                Icons.emoji_events,
                "Lv ${LevelHelper.getLevel(child.xp)}",
                "Level",
              ),
              _infoTile(
                Icons.local_fire_department,
                "${child.streak}",
                "Streak",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoTile(
    IconData icon,
    String value,
    String label,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildRankCard(
    Child child,
    int rank,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: _rankColor(rank),
              child: Text(
                "$rank",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    child.name,
                    style: AppTextStyles.title,
                  ),

                  const SizedBox(height: 6),

                  Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      "Level ${LevelHelper.getLevel(child.xp)}",
    ),

    const SizedBox(height: 6),

    _rankBadge(rank),
  ],
),

                  const SizedBox(height: 12),

                  LinearProgressIndicator(
                    value: LevelHelper.getProgress(
                      child.xp,
                    ),
                    minHeight: 8,
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 18),

            Column(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.orange,
                ),
                Text("${child.xp}"),

                const SizedBox(height: 10),

                const Icon(
                  Icons.local_fire_department,
                  color: Colors.deepOrange,
                ),
                Text("${child.streak}"),
              ],
            ),
          ],
        ),
      ),
    )
        .animate()
        .fade(duration: 500.ms)
        .slideX(begin: .20);
  }  Color _rankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber;

      case 2:
        return Colors.grey;

      case 3:
        return Colors.brown;

      default:
        return AppColors.primary;
    }
  }

  String _rankTitle(int rank) {
    switch (rank) {
      case 1:
        return "Champion";

      case 2:
        return "Runner Up";

      case 3:
        return "Top Performer";

      default:
        return "Competitor";
    }
  }

  Widget _rankBadge(int rank) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: _rankColor(rank),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _rankTitle(rank),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}