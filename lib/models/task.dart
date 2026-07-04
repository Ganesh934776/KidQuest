class Task {
  final String id;
  final String title;
  final String description;
  final int xp;
  final String deadline;
  final String childId;
  bool isCompleted;

  Task({
    this.id = '',
    required this.title,
    required this.description,
    required this.xp,
    required this.deadline,
    required this.childId,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'xp': xp,
      'deadline': deadline,
      'childId': childId,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromMap(String id, Map<String, dynamic> map) {
    return Task(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      xp: map['xp'] ?? 0,
      deadline: map['deadline'] ?? '',
      childId: map['childId'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}