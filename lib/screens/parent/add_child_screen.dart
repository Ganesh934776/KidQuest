import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kidquest/services/child_service.dart';

class AddChildScreen extends StatefulWidget {
  const AddChildScreen({super.key});

  @override
  State<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> saveChild() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      setState(() {
        isLoading = true;
      });

      final parentId = FirebaseAuth.instance.currentUser!.uid;

      final childService = ChildService();

      // Generate one unique child code
      final childCode = childService.generateChildCode();

      // Save child to Firestore
      await childService.addChild(
        parentId: parentId,
        name: _nameController.text.trim(),
        age: int.parse(_ageController.text.trim()),
        childCode: childCode,
      );

      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Child Added Successfully"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 60,
              ),
              const SizedBox(height: 20),
              Text(
                _nameController.text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Child Login Code",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              SelectableText(
                childCode,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Save this code.\nThe child will use it to log in.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );

      if (!mounted) return;

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  InputDecoration inputDecoration(
    String label,
    IconData icon,
  ) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Child"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const Icon(
                  Icons.child_care,
                  size: 90,
                  color: Colors.blue,
                ),

                const SizedBox(height: 20),

                const Text(
                  "Register Child",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 35),

                TextFormField(
                  controller: _nameController,
                  decoration: inputDecoration(
                    "Child Name",
                    Icons.person,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter child name";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: inputDecoration(
                    "Age",
                    Icons.cake,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter age";
                    }

                    if (int.tryParse(value) == null) {
                      return "Enter a valid age";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 35),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: isLoading ? null : saveChild,
                    icon: const Icon(Icons.save),
                    label: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Add Child",
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}