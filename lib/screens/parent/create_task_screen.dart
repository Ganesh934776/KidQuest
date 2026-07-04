import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kidquest/models/child.dart';
import 'package:kidquest/models/task.dart';
import 'package:kidquest/services/child_service.dart';
import 'package:kidquest/services/task_service.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _xpController = TextEditingController();
  final _deadlineController = TextEditingController();

  Child? selectedChild;

  final childService = ChildService();
  final taskService = TaskService();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _xpController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  Future<void> saveTask() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedChild == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a child"),
        ),
      );
      return;
    }

    final task = Task(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      xp: int.parse(_xpController.text.trim()),
      deadline: _deadlineController.text.trim(),
      childId: selectedChild!.id,
    );

    await taskService.addTask(task);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Task Assigned Successfully!"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final parentId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Task"),
      ),
      body: StreamBuilder<List<Child>>(
        stream: childService.getChildren(parentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final children = snapshot.data ?? [];

          if (children.isEmpty) {
            return const Center(
              child: Text(
                "No children found.\nPlease add a child first.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  DropdownButtonFormField<Child>(
                    initialValue: selectedChild,
                    decoration: const InputDecoration(
                      labelText: "Select Child",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.child_care),
                    ),
                    items: children.map((child) {
                      return DropdownMenuItem(
                        value: child,
                        child: Text(child.name),
                      );
                    }).toList(),
                    onChanged: (child) {
                      setState(() {
                        selectedChild = child;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Please select a child";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: "Task Title",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter title" : null,
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter description" : null,
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _xpController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "XP Reward",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter XP";
                      }
                      if (int.tryParse(value) == null) {
                        return "Enter valid XP";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _deadlineController,
                    decoration: const InputDecoration(
                      labelText: "Deadline",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter deadline" : null,
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      onPressed: saveTask,
                      child: const Text(
                        "Assign Task",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}