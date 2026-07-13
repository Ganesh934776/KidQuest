import 'package:flutter/material.dart';
import 'package:kidquest/screens/child/child_dashboard_screen.dart';
import 'package:kidquest/services/child_service.dart';
import 'package:kidquest/services/session_service.dart';

class ChildLoginScreen extends StatefulWidget {
  const ChildLoginScreen({super.key});

  @override
  State<ChildLoginScreen> createState() => _ChildLoginScreenState();
}

class _ChildLoginScreenState extends State<ChildLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _childCodeController =
      TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    _childCodeController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final child = await ChildService().login(
      _childCodeController.text.trim(),
    );

    if (!mounted) return;

    setState(() => isLoading = false);

    if (child == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid Child Code"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    await SessionService().saveChildSession(child.id);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ChildDashboardScreen(
          childId: child.id,
        ),
      ),
    );
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
        title: const Text("Child Login"),
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
                  size: 100,
                  color: Colors.blue,
                ),
                const SizedBox(height: 25),
                const Text(
                  "Child Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Enter your Child Code",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 35),
                TextFormField(
                  controller: _childCodeController,
                  keyboardType: TextInputType.number,
                  decoration: inputDecoration(
                    "Child Code",
                    Icons.password,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Child Code";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 35),
                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : login,
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Login",
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