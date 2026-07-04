import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<int> getChildrenCount(String parentId) async {
    final snapshot = await _firestore
        .collection('children')
        .where('parentId', isEqualTo: parentId)
        .get();

    return snapshot.docs.length;
  }

  Future<int> getTotalXP(String parentId) async {
    final snapshot = await _firestore
        .collection('children')
        .where('parentId', isEqualTo: parentId)
        .get();

    int totalXP = 0;

    for (final child in snapshot.docs) {
      totalXP += (child.data()['xp'] ?? 0) as int;
    }

    return totalXP;
  }

  Future<int> getTaskCount() async {
    final snapshot =
        await _firestore.collection('tasks').get();

    return snapshot.docs.length;
  }

  Future<int> getRewardCount() async {
    final snapshot =
        await _firestore.collection('rewards').get();

    return snapshot.docs.length;
  }
}