import 'package:cloud_firestore/cloud_firestore.dart';

class ParentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Create a new parent document
  Future<void> createParent({
    required String uid,
    required String name,
    required String email,
  }) async {
    await _firestore.collection('parents').doc(uid).set({
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Get a parent's data
  Future<Map<String, dynamic>?> getParent(String uid) async {
    final doc = await _firestore.collection('parents').doc(uid).get();

    if (doc.exists) {
      return doc.data();
    }

    return null;
  }

  /// Update parent profile
  Future<void> updateParent({
    required String uid,
    required String name,
    required String email,
  }) async {
    await _firestore.collection('parents').doc(uid).update({
      'name': name,
      'email': email,
    });
  }

  /// Delete parent account from Firestore
  Future<void> deleteParent(String uid) async {
    await _firestore.collection('parents').doc(uid).delete();
  }
}