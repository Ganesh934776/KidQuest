import 'package:cloud_firestore/cloud_firestore.dart';

class DailyReward {
  final String id;
  final String childId;
  final String rewardType;
  final int rewardValue;
  final String claimedDate;
  final Timestamp claimedAt;

  DailyReward({
    required this.id,
    required this.childId,
    required this.rewardType,
    required this.rewardValue,
    required this.claimedDate,
    required this.claimedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'childId': childId,
      'rewardType': rewardType,
      'rewardValue': rewardValue,
      'claimedDate': claimedDate,
      'claimedAt': claimedAt,
    };
  }

  factory DailyReward.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return DailyReward(
      id: id,
      childId: map['childId'],
      rewardType: map['rewardType'],
      rewardValue: map['rewardValue'],
      claimedDate: map['claimedDate'],
      claimedAt: map['claimedAt'],
    );
  }
}