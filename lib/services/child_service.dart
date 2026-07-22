import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kidquest/models/child.dart';

class ChildService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Generate random 6-digit child code
  String generateChildCode() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  /// Add child
  Future<void> addChild({
    required String parentId,
    required String name,
    required int age,
    required String childCode,
  }) async {
    final doc = _firestore.collection('children').doc();

    final child = Child(
      id: doc.id,
      parentId: parentId,
      name: name,
      age: age,
      childCode: childCode,
      xp: 0,
    );

    await doc.set(child.toMap());
  }

  /// Get all children of a parent
  Stream<List<Child>> getChildren(String parentId) {
    return _firestore
        .collection('children')
        .where('parentId', isEqualTo: parentId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Child.fromMap(
                  doc.id,
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  /// Get one child
  Stream<Child> getChild(String childId) {
    return _firestore
        .collection('children')
        .doc(childId)
        .snapshots()
        .map(
          (doc) => Child.fromMap(
            doc.id,
            doc.data()!,
          ),
        );
  }

  /// Child login
  Future<Child?> login(String childCode) async {
    final snapshot = await _firestore
        .collection('children')
        .where(
          'childCode',
          isEqualTo: childCode,
        )
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    final doc = snapshot.docs.first;

    return Child.fromMap(
      doc.id,
      doc.data(),
    );
  }

  /// Leaderboard (all children sorted by XP)
  Stream<List<Child>> getLeaderboard() {
    return _firestore
        .collection('children')
        .orderBy('xp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Child.fromMap(
                  doc.id,
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  /// Update XP
  Future<void> updateXP(
    String childId,
    int xp,
  ) async {
    await _firestore
        .collection('children')
        .doc(childId)
        .update({
      'xp': xp,
    });
  }

  /// Update Coins
  Future<void> updateCoins(
    String childId,
    int coins,
  ) async {
    await _firestore
        .collection('children')
        .doc(childId)
        .update({
      'coins': coins,
    });
  }

  /// Update Streak
  Future<void> updateStreak(
    String childId,
    int streak,
  ) async {
    await _firestore
        .collection('children')
        .doc(childId)
        .update({
      'streak': streak,
    });
  }
  /// Update multiple child fields together
Future<void> updateChildStats({
  required String childId,
  int? xp,
  int? coins,
  int? streak,
  DateTime? lastCompletedDate,
}) async {
  final Map<String, dynamic> updates = {};

  if (xp != null) {
    updates['xp'] = xp;
  }

  if (coins != null) {
    updates['coins'] = coins;
  }

  if (streak != null) {
    updates['streak'] = streak;
  }

  if (lastCompletedDate != null) {
    updates['lastCompletedDate'] =
        Timestamp.fromDate(lastCompletedDate);
  }

  if (updates.isEmpty) return;

  await _firestore
      .collection('children')
      .doc(childId)
      .update(updates);
}

  /// Delete child
  Future<void> deleteChild(String childId) async {
    await _firestore
        .collection('children')
        .doc(childId)
        .delete();
  }
}