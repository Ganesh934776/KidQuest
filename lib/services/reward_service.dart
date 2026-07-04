import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kidquest/models/reward.dart';

class RewardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Add Reward
  Future<void> addReward(Reward reward) async {
    final doc = _firestore.collection('rewards').doc();

    final newReward = Reward(
      id: doc.id,
      parentId: reward.parentId,
      title: reward.title,
      description: reward.description,
      coinCost: reward.coinCost,
      isAvailable: reward.isAvailable,
    );

    await doc.set(newReward.toMap());
  }

  /// Rewards created by a parent
  Stream<List<Reward>> getRewards(String parentId) {
    return _firestore
        .collection('rewards')
        .where('parentId', isEqualTo: parentId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Reward.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  /// Rewards available for children
  Stream<List<Reward>> getAvailableRewards() {
    return _firestore
        .collection('rewards')
        .where('isAvailable', isEqualTo: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Reward.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  /// All rewards
  Stream<List<Reward>> getAllRewards() {
    return _firestore
        .collection('rewards')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Reward.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  /// Redeem reward using coins
  Future<bool> redeemReward({
    required Reward reward,
    required String childId,
  }) async {
    final childRef =
        _firestore.collection('children').doc(childId);

    final redeemedRef =
        _firestore.collection('redeemed_rewards').doc();

    try {
      await _firestore.runTransaction((transaction) async {
        final childSnapshot =
            await transaction.get(childRef);

        if (!childSnapshot.exists) {
          throw Exception("Child not found");
        }

        final currentCoins =
            childSnapshot.data()?['coins'] ?? 0;

        if (currentCoins < reward.coinCost) {
          throw Exception("Not enough coins");
        }

        transaction.update(childRef, {
          'coins': currentCoins - reward.coinCost,
        });

        transaction.set(redeemedRef, {
          'rewardId': reward.id,
          'rewardTitle': reward.title,
          'coinCost': reward.coinCost,
          'childId': childId,
          'redeemedAt': Timestamp.now(),
        });
      });

      return true;
    } catch (_) {
      return false;
    }
  }

  /// Update reward
  Future<void> updateReward(Reward reward) async {
    await _firestore
        .collection('rewards')
        .doc(reward.id)
        .update(reward.toMap());
  }

  /// Delete reward
  Future<void> deleteReward(String rewardId) async {
    await _firestore
        .collection('rewards')
        .doc(rewardId)
        .delete();
  }
}