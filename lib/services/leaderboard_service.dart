import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kidquest/models/child.dart';
import 'package:kidquest/models/leaderboard_entry.dart';

class LeaderboardService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Stream<List<LeaderboardEntry>> getLeaderboard() {
    return _firestore
        .collection("children")
        .orderBy("xp", descending: true)
        .snapshots()
        .map((snapshot) {
      final children = snapshot.docs
          .map(
            (e) => Child.fromMap(
              e.id,
              e.data(),
            ),
          )
          .toList();

      return List.generate(
        children.length,
        (index) => LeaderboardEntry(
          child: children[index],
          rank: index + 1,
        ),
      );
    });
  }
}