import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:kidquest/screens/parent/parent_dashboard_screen.dart';
import 'package:kidquest/screens/parent/parent_register_screen.dart';
import 'package:kidquest/screens/parent/forgot_password_screen.dart';

import 'package:kidquest/services/parent_service.dart';
import 'package:kidquest/services/session_service.dart';

class ParentLoginScreen extends StatefulWidget {
  const ParentLoginScreen({super.key});

  @override
  State<ParentLoginScreen> createState() =>
      _ParentLoginScreenState();
}

class _ParentLoginScreenState
    extends State<ParentLoginScreen> {
  final TextEditingController
      _usernameController =
      TextEditingController();

  final TextEditingController
      _passwordController =
      TextEditingController();

  bool _rememberMe = true;
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    final username =
        _usernameController.text.trim();

    final password =
        _passwordController.text.trim();

    if (username.isEmpty ||
        password.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
              "Please enter Username/Email and Password"),
        ),
      );
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      String email = username;

      // If user entered username
      if (!username.contains("@")) {
        final result =
            await ParentService()
                .getEmailFromUsername(
                    username);

        if (result == null) {
          throw FirebaseAuthException(
            code: "user-not-found",
            message:
                "Username not found",
          );
        }

        email = result;
      }

      final credential =
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (_rememberMe) {
        await SessionService()
            .saveParentSession(
          credential.user!.uid,
        );
      }

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const ParentDashboardScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
     String message;

switch (e.code) {
  case "wrong-password":
    message = "Incorrect password.";
    break;

  case "user-not-found":
    message = "User not found.";
    break;

  case "invalid-email":
    message = "Invalid email.";
    break;

  case "invalid-credential":
    message = "Invalid username or password.";
    break;

  default:
    message = e.message ?? "Login failed.";
}

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(message),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Parent Login"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(24),
          child: Column(
            children: [

              const SizedBox(
                  height: 20),

              const Icon(
                Icons.family_restroom,
                size: 90,
                color: Colors.blue,
              ),

              const SizedBox(
                  height: 20),

              const Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                  height: 8),

              const Text(
                "Login using Username or Email",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(
                  height: 35),              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Username or Email",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword =
                            !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe =
                            value ?? true;
                      });
                    },
                  ),

                  const Text("Remember Me"),

                  const Spacer(),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed:
                      _isLoading ? null : login,
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 20),

              const Divider(),

              const SizedBox(height: 10),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const ParentRegisterScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Create New Parent Account",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}