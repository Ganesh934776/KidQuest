import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  late final Animation<double> _scale;
  late final Animation<Offset> _slide;

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

    _scale = Tween<double>(
      begin: .92,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, .15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openParent() {
    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const ParentDashboardScreen(),
        ),
      );
    } else {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/welcome_hero.png",
            fit: BoxFit.cover,
          ),

          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x22000000),
                  Color(0x66000000),
                  Color(0xDD000000),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: FadeTransition(
                  opacity: _fade,
                  child: SlideTransition(
                    position: _slide,
                    child: ScaleTransition(
                      scale: _scale,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 470,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(34),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 18,
                              sigmaY: 18,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(
                                  alpha: .14,
                                ),
                                borderRadius:
                                    BorderRadius.circular(34),
                                border: Border.all(
                                  color: Colors.white.withValues(
                                    alpha: .18,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withValues(
                                        alpha: .12,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.auto_awesome,
                                      color: Colors.amber,
                                      size: 42,
                                    ),
                                  ),

                                  const SizedBox(height: 24),

                                  const Text(
                                    "Welcome to",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 20,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  const Text(
                                    "KidQuest",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 42,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),

                                  const SizedBox(height: 14),

                                  const Text(
                                    "Build habits, earn rewards and create unforgettable moments together.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                      height: 1.6,
                                    ),
                                  ),

                                  const SizedBox(height: 28),

                                  const Wrap(
                                    spacing: 12,
                                    runSpacing: 12,
                                    children: [
                                      _FeatureTile(
                                        icon: Icons.task_alt,
                                        title: "Daily Missions",
                                      ),
                                      _FeatureTile(
                                        icon: Icons.stars,
                                        title: "Earn XP",
                                      ),
                                      _FeatureTile(
                                        icon: Icons.card_giftcard,
                                        title: "Rewards",
                                      ),
                                      _FeatureTile(
                                        icon: Icons.emoji_events,
                                        title: "Leaderboard",
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 34),                                  SizedBox(
                                    width: double.infinity,
                                    height: 62,
                                    child: _RoleButton(
                                      icon: Icons.family_restroom_rounded,
                                      title: "Continue as Parent",
                                      filled: true,
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF5B5FEF),
                                          Color(0xFF7B61FF),
                                        ],
                                      ),
                                      onTap: _openParent,
                                    ),
                                  ),

                                  const SizedBox(height: 18),

                                  SizedBox(
                                    width: double.infinity,
                                    height: 62,
                                    child: _RoleButton(
                                      icon: Icons.child_care_rounded,
                                      title: "Continue as Child",
                                      filled: false,
                                      onTap: _openChild,
                                    ),
                                  ),

                                  const SizedBox(height: 30),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          color: Colors.white.withValues(
                                            alpha: .25,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                        ),
                                        child: Text(
                                          "KidQuest",
                                          style: TextStyle(
                                            color: Colors.white.withValues(
                                              alpha: .70,
                                            ),
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: Colors.white.withValues(
                                            alpha: .25,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 18),

                                  const Text(
                                    "Every small habit builds a brighter future 🌟",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 15,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const _FeatureTile({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: .15),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.amber,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool filled;
  final VoidCallback onTap;
  final Gradient? gradient;

  const _RoleButton({
    required this.icon,
    required this.title,
    required this.filled,
    required this.onTap,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
        const SizedBox(width: 14),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );

    if (filled) {
      return DecoratedBox(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: content,
        ),
      );
    }

    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white.withValues(alpha: .08),
        foregroundColor: Colors.white,
        side: BorderSide(
          color: Colors.white.withValues(alpha: .55),
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: content,
    );
  }
}