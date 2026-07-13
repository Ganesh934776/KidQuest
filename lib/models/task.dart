import 'package:cloud_firestore/cloud_firestore.dart';

enum TaskStatus {
  pending,
  completed,
  missed,
}

class Task {
  final String id;
  final String childId;

  final String title;
  final String description;

  final String icon;
  final String color;

  final int xp;
  final int coins;

  /// Date of task
  final DateTime dueDate;

  /// Example: 07:15
  final String submissionTime;

  final bool isCompleted;

  final DateTime? completedAt;

  final DateTime createdAt;

  final bool isRecurring;

  /// none | one_day | unlimited
  final String latePolicy;

  final TaskStatus status;

   Task({
    this.id = '',
    required this.childId,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.xp,
    required this.coins,
    required this.dueDate,
    required this.submissionTime,
    this.isCompleted = false,
    this.completedAt,
    DateTime? createdAt,
    this.isRecurring = true,
    this.latePolicy = "none",
    this.status = TaskStatus.pending,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      "childId": childId,
      "title": title,
      "description": description,
      "icon": icon,
      "color": color,
      "xp": xp,
      "coins": coins,
      "dueDate": Timestamp.fromDate(dueDate),
      "submissionTime": submissionTime,
      "isCompleted": isCompleted,
      "completedAt":
          completedAt != null ? Timestamp.fromDate(completedAt!) : null,
      "createdAt": Timestamp.fromDate(createdAt),
      "isRecurring": isRecurring,
      "latePolicy": latePolicy,
      "status": status.name,
    };
  }

  factory Task.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return Task(
      id: id,
      childId: map["childId"] ?? "",

      title: map["title"] ?? "",
      description: map["description"] ?? "",

      icon: map["icon"] ?? "task",
      color: map["color"] ?? "#4CAF50",

      xp: map["xp"] ?? 0,
      coins: map["coins"] ?? 0,

      dueDate: map["dueDate"] != null
          ? (map["dueDate"] as Timestamp).toDate()
          : DateTime.now(),

      submissionTime: map["submissionTime"] ?? "23:59",

      isCompleted: map["isCompleted"] ?? false,

      completedAt: map["completedAt"] != null
          ? (map["completedAt"] as Timestamp).toDate()
          : null,

      createdAt: map["createdAt"] != null
          ? (map["createdAt"] as Timestamp).toDate()
          : DateTime.now(),

      isRecurring: map["isRecurring"] ?? true,

      latePolicy: map["latePolicy"] ?? "none",

      status: TaskStatus.values.firstWhere(
        (e) => e.name == (map["status"] ?? "pending"),
        orElse: () => TaskStatus.pending,
      ),
    );
  }

  Task copyWith({
    String? id,
    String? childId,
    String? title,
    String? description,
    String? icon,
    String? color,
    int? xp,
    int? coins,
    DateTime? dueDate,
    String? submissionTime,
    bool? isCompleted,
    DateTime? completedAt,
    DateTime? createdAt,
    bool? isRecurring,
    String? latePolicy,
    TaskStatus? status,
  }) {
    return Task(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      xp: xp ?? this.xp,
      coins: coins ?? this.coins,
      dueDate: dueDate ?? this.dueDate,
      submissionTime: submissionTime ?? this.submissionTime,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      isRecurring: isRecurring ?? this.isRecurring,
      latePolicy: latePolicy ?? this.latePolicy,
      status: status ?? this.status,
    );
  }
}