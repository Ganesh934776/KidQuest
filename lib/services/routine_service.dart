import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kidquest/models/task.dart';
import 'package:kidquest/utils/routine_templates.dart';

class RoutineService {
  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  Future<void> generateRoutine(
      String childId) async {
    final today = DateTime.now();

    final start =
        DateTime(today.year, today.month, today.day);

    final end = start.add(const Duration(days: 1));

    final existing = await firestore
        .collection("tasks")
        .where("childId", isEqualTo: childId)
        .where("dueDate",
            isGreaterThanOrEqualTo:
                Timestamp.fromDate(start))
        .where("dueDate",
            isLessThan: Timestamp.fromDate(end))
        .get();

    if (existing.docs.isNotEmpty) {
      return;
    }

    final batch = firestore.batch();

    for (final item
        in RoutineTemplates.getTasks(childId)) {
      final doc =
          firestore.collection("tasks").doc();

      batch.set(
          doc,
          Task(
            id: doc.id,
            childId: childId,
            title: item["title"],
            description: item["description"],
            icon: item["icon"],
            color: item["color"],
            xp: item["xp"],
            coins: item["coins"],
            dueDate: start,
            submissionTime:
                item["submissionTime"],
          ).toMap());
    }

    await batch.commit();
  }
}