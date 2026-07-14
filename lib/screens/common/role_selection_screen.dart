import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:kidquest/screens/child/child_login_screen.dart';
import 'package:kidquest/screens/parent/parent_dashboard_screen.dart';
import 'package:kidquest/screens/parent/parent_login_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() =>
      _RoleSelectionScreenState();
}

class _RoleSelectionScreenState
    extends State<RoleSelectionScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _fade;

  late final Animation<Offset> _slide;

  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, .25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _scale = Tween<double>(
      begin: .94,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _openParent() async {
    if (FirebaseAuth.instance.currentUser != null) {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const ParentDashboardScreen(),
        ),
      );
    } else {
      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ParentLoginScreen(),
        ),
      );
    }
  }

  void _openChild() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ChildLoginScreen(),
      ),
    );
  }  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: ScaleTransition(
        scale: _scale,
        child: FadeTransition(
          opacity: _fade,
          child: Stack(
            fit: StackFit.expand,
            children: [

              /// Background Image
              Image.asset(
                "assets/images/welcome_hero.png",
                fit: BoxFit.cover,
              ),

              /// Dark Gradient Overlay
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(0, 0, 0, .18),
                      Color.fromRGBO(0, 0, 0, .10),
                      Color.fromRGBO(0, 0, 0, .55),
                    ],
                  ),
                ),
              ),

              /// Page Content
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: SlideTransition(
                    position: _slide,
                    child: Column(
                      children: [

                        const SizedBox(height: 40),

                        const Text(
                          "Welcome to",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 4),

                        const Text(
                          "KidQuest",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.3,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          "Learn • Play • Grow",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 17,
                          ),
                        ),

                        const Spacer(),

                        // PART 3 STARTS HERE...                        /// Parent Button
                        SizedBox(
                          width: double.infinity,
                          height: 62,
                          child: ElevatedButton.icon(
                            onPressed: _openParent,
                            icon: const Icon(
                              Icons.family_restroom_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                            label: const Text(
                              "I'm a Parent",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4F46E5),
                              foregroundColor: Colors.white,
                              elevation: 12,
                              shadowColor: Colors.black45,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        /// Child Button
                        SizedBox(
                          width: double.infinity,
                          height: 62,
                          child: OutlinedButton.icon(
                            onPressed: _openChild,
                            icon: const Icon(
                              Icons.child_care_rounded,
                              size: 28,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "I'm a Child",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                              backgroundColor:
                                  Colors.white.withValues(alpha: 0.12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: size.height * .06),

                        const Text(
                          "Every small habit builds a brighter future 🌟",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        SizedBox(height: size.height * .04),
                      ],
                    ),
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