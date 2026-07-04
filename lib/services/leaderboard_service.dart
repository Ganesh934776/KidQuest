import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kidquest/models/child.dart';

class LeaderboardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Child>> getLeaderboard(String parentId) {
    return _firestore
        .collection('children')
        .where('parentId', isEqualTo: parentId)
        .orderBy('xp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Child.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }
}