class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon;
  final bool unlocked;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    this.unlocked = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'icon': icon,
      'unlocked': unlocked,
    };
  }

  factory Achievement.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return Achievement(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      icon: map['icon'] ?? '🏆',
      unlocked: map['unlocked'] ?? false,
    );
  }
}