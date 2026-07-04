import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kidquest/models/child.dart';

class ChildService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Generate a random 6-digit child code
  String generateChildCode() {
    final random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  /// Add child to Firestore
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
              .map((doc) => Child.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  /// Get a single child's live data
  Stream<Child> getChild(String childId) {
    return _firestore
        .collection('children')
        .doc(childId)
        .snapshots()
        .map(
          (doc) => Child.fromMap(doc.id, doc.data()!),
        );
  }

  /// Login using child code
  Future<Child?> login(String childCode) async {
    final snapshot = await _firestore
        .collection('children')
        .where('childCode', isEqualTo: childCode)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    final doc = snapshot.docs.first;

    return Child.fromMap(doc.id, doc.data());
  }
}