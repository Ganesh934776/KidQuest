import 'package:cloud_firestore/cloud_firestore.dart';

class ParentService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  /// ==========================
  /// Create Parent
  /// ==========================
  Future<void> createParent({
    required String uid,
    required String name,
    required String username,
    required String email,
  }) async {
    await _firestore
        .collection("parents")
        .doc(uid)
        .set({
      "name": name,
      "username": username.toLowerCase(),
      "email": email.toLowerCase(),
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  /// ==========================
  /// Get Parent
  /// ==========================
  Future<Map<String, dynamic>?> getParent(
    String uid,
  ) async {
    final doc = await _firestore
        .collection("parents")
        .doc(uid)
        .get();

    if (!doc.exists) return null;

    return doc.data();
  }

  /// ==========================
  /// Check Username Exists
  /// ==========================
  Future<bool> usernameExists(
    String username,
  ) async {
    final snapshot = await _firestore
        .collection("parents")
        .where(
          "username",
          isEqualTo: username.toLowerCase(),
        )
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  /// ==========================
  /// Find Email by Username
  /// ==========================
  Future<String?> getEmailFromUsername(
    String username,
  ) async {
    final snapshot = await _firestore
        .collection("parents")
        .where(
          "username",
          isEqualTo: username.toLowerCase(),
        )
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return snapshot.docs.first["email"];
  }

  /// ==========================
  /// Update Parent
  /// ==========================
  Future<void> updateParent({
    required String uid,
    required String name,
    required String username,
    required String email,
  }) async {
    await _firestore
        .collection("parents")
        .doc(uid)
        .update({
      "name": name,
      "username": username.toLowerCase(),
      "email": email.toLowerCase(),
    });
  }

  /// ==========================
  /// Delete Parent
  /// ==========================
  Future<void> deleteParent(
    String uid,
  ) async {
    await _firestore
        .collection("parents")
        .doc(uid)
        .delete();
  }
}