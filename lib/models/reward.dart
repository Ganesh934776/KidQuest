class Reward {
  final String id;
  final String parentId;
  final String title;
  final String description;

  /// Coins required to redeem this reward
  final int coinCost;

  final bool isAvailable;

  const Reward({
    this.id = '',
    required this.parentId,
    required this.title,
    required this.description,
    required this.coinCost,
    this.isAvailable = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'parentId': parentId,
      'title': title,
      'description': description,
      'coinCost': coinCost,
      'isAvailable': isAvailable,
    };
  }

  factory Reward.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return Reward(
      id: id,
      parentId: map['parentId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',

      // Backward compatibility
      coinCost: map['coinCost'] ?? map['xpCost'] ?? 0,

      isAvailable: map['isAvailable'] ?? true,
    );
  }

  Reward copyWith({
    String? id,
    String? parentId,
    String? title,
    String? description,
    int? coinCost,
    bool? isAvailable,
  }) {
    return Reward(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      title: title ?? this.title,
      description: description ?? this.description,
      coinCost: coinCost ?? this.coinCost,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}