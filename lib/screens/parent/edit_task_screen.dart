import 'package:flutter/material.dart';
import 'package:kidquest/models/task.dart';
import 'package:kidquest/services/task_service.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  const EditTaskScreen({
    super.key,
    required this.task,
  });

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _deadlineController;
  late TextEditingController _xpController;

  final TaskService _taskService = TaskService();

  @override
  void initState() {
    super.initState();

    _titleController =
        TextEditingController(text: widget.task.title);

    _descriptionController =
        TextEditingController(text: widget.task.description);

    _deadlineController =
        TextEditingController(text: widget.task.deadline);

    _xpController =
        TextEditingController(text: widget.task.xp.toString());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _deadlineController.dispose();
    _xpController.dispose();
    super.dispose();
  }

  Future<void> _saveTask() async {
    if (!_formKey.currentState!.validate()) return;

    final updatedTask = Task(
      id: widget.task.id,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      deadline: _deadlineController.text.trim(),
      xp: int.parse(_xpController.text),
      childId: widget.task.childId,
      isCompleted: widget.task.isCompleted,
    );

    await _taskService.updateTask(updatedTask);

    if (!mounted) return;

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Task updated successfully!"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration:
                    const InputDecoration(labelText: "Title"),
                validator: (value) =>
                    value!.isEmpty ? "Enter title" : null,
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: _descriptionController,
                decoration:
                    const InputDecoration(labelText: "Description"),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: _deadlineController,
                decoration:
                    const InputDecoration(labelText: "Deadline"),
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: _xpController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: "XP"),
                validator: (value) =>
                    value!.isEmpty ? "Enter XP" : null,
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _saveTask,
                child: const Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}