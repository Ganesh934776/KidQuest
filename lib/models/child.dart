import 'package:cloud_firestore/cloud_firestore.dart';

class Child {
  final String id;
  final String parentId;
  final String name;
  final int age;
  final String childCode;

  /// Experience Points
  final int xp;

  /// Coins earned by completing tasks
  final int coins;

  /// Daily streak
  final int streak;

  /// Last completed task date
  final DateTime? lastCompletedDate;

  const Child({
    required this.id,
    required this.parentId,
    required this.name,
    required this.age,
    required this.childCode,
    this.xp = 0,
    this.coins = 0,
    this.streak = 0,
    this.lastCompletedDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'parentId': parentId,
      'name': name,
      'age': age,
      'childCode': childCode,
      'xp': xp,
      'coins': coins,
      'streak': streak,
      'lastCompletedDate': lastCompletedDate != null
          ? Timestamp.fromDate(lastCompletedDate!)
          : null,
    };
  }

  factory Child.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return Child(
      id: id,
      parentId: map['parentId'] ?? '',
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      childCode: map['childCode'] ?? '',
      xp: map['xp'] ?? 0,
      coins: map['coins'] ?? 0,
      streak: map['streak'] ?? 0,
      lastCompletedDate: map['lastCompletedDate'] != null
          ? (map['lastCompletedDate'] as Timestamp).toDate()
          : null,
    );
  }

  Child copyWith({
    String? id,
    String? parentId,
    String? name,
    int? age,
    String? childCode,
    int? xp,
    int? coins,
    int? streak,
    DateTime? lastCompletedDate,
  }) {
    return Child(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      name: name ?? this.name,
      age: age ?? this.age,
      childCode: childCode ?? this.childCode,
      xp: xp ?? this.xp,
      coins: coins ?? this.coins,
      streak: streak ?? this.streak,
      lastCompletedDate:
          lastCompletedDate ?? this.lastCompletedDate,
    );
  }
}