import 'dart:math';

import 'package:flutter/material.dart';

class PremiumParentHeader extends StatefulWidget {
  final String parentName;
  final int children;
  final int totalXp;

  const PremiumParentHeader({
    super.key,
    required this.parentName,
    required this.children,
    required this.totalXp,
  });

  @override
  State<PremiumParentHeader> createState() =>
      _PremiumParentHeaderState();
}

class _PremiumParentHeaderState
    extends State<PremiumParentHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Container(
          height: 310,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff6C63FF),
                Color(0xff4FC3F7),
              ],
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 25,
                color: Colors.blue.withValues(alpha: 0.25),
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            children: [

              _bubble(
                35,
                40,
                70,
                Colors.white.withValues(alpha: 0.12),
              ),

              _bubble(
                280,
                35,
                45,
                Colors.white.withValues(alpha: 0.10),
              ),

              _bubble(
                260,
                150,
                90,
                Colors.white.withValues(alpha: 0.08),
              ),

              _bubble(
                40,
                170,
                55,
                Colors.white.withValues(alpha: 0.08),
              ),

              Positioned(
                left: 25,
                top: 30,
                child: Transform.translate(
                  offset: Offset(
                    sin(controller.value * pi * 2) * 8,
                    0,
                  ),
                  child: const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 24,
                  ),
                ),
              ),

              Positioned(
                right: 35,
                top: 70,
                child: Transform.translate(
                  offset: Offset(
                    0,
                    cos(controller.value * pi * 2) * 10,
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.pinkAccent,
                    size: 20,
                  ),
                ),
              ),

              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [

                      Transform.translate(
                        offset: Offset(
                          0,
                          sin(controller.value * pi * 2) * 6,
                        ),
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 18,
                                color: Colors.white
                                    .withValues(alpha: 0.35),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.family_restroom,
                            size: 52,
                            color: Color(0xff6C63FF),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        "Welcome Back 👋",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        widget.parentName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                        children: [

                          _info(
                            Icons.child_care,
                            widget.children.toString(),
                            "Children",
                          ),

                          Container(
                            height: 45,
                            width: 1,
                            color: Colors.white30,
                          ),

                          _info(
                            Icons.star,
                            widget.totalXp.toString(),
                            "XP",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _info(
    IconData icon,
    String value,
    String title,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _bubble(
    double left,
    double top,
    double size,
    Color color,
  ) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}