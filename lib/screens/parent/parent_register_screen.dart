import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kidquest/screens/parent/parent_dashboard_screen.dart';
import 'package:kidquest/services/parent_service.dart';

class ParentRegisterScreen extends StatefulWidget {
  const ParentRegisterScreen({super.key});

  @override
  State<ParentRegisterScreen> createState() =>
      _ParentRegisterScreenState();
}

class _ParentRegisterScreenState
    extends State<ParentRegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
        ),
      );
      return;
    }

    try {
      setState(() => isLoading = true);

      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await ParentService().createParent(
        uid: credential.user!.uid,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const ParentDashboardScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = e.message ?? "Registration failed";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Parent Registration"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              const Icon(
                Icons.family_restroom,
                size: 90,
                color: Colors.blue,
              ),

              const SizedBox(height: 25),

              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Parent Name",
                  prefixIcon: Icon(Icons.person),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                ),
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : register,
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Register",
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}