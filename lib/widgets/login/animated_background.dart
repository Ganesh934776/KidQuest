import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:kidquest/widgets/login/efects/floating_cloud.dart';
import 'package:kidquest/widgets/login/efects/floating_coin.dart';
import 'package:kidquest/widgets/login/efects/floating_star.dart';
import 'package:kidquest/widgets/login/efects/floating_trophy.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;

  const AnimatedBackground({
    super.key,
    required this.child,
  });

  @override
  State<AnimatedBackground> createState() =>
      _AnimatedBackgroundState();
}

class _AnimatedBackgroundState
    extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget bubble(
    double left,
    double top,
    double size,
    Color color,
  ) {
    return Positioned(
      left: left,
      top: top,
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          return Transform.translate(
            offset: Offset(
              0,
              sin(controller.value * 2 * pi) * 10,
            ),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff6C63FF),
            Color(0xff4F8CFF),
            Color(0xff8FD3FF),
          ],
        ),
      ),
      child: Stack(
        children: [

          /// Floating Blur Circles
          bubble(
            -60,
            120,
            180,
            Colors.white.withValues(alpha: .08),
          ),

          bubble(
            280,
            40,
            150,
            Colors.white.withValues(alpha: .08),
          ),

          bubble(
            40,
            500,
            120,
            Colors.white.withValues(alpha: .07),
          ),

          bubble(
            320,
            620,
            220,
            Colors.white.withValues(alpha: .06),
          ),

          bubble(
            -50,
            760,
            170,
            Colors.white.withValues(alpha: .05),
          ),

          /// Clouds
          const FloatingCloud(
            left: 20,
            top: 80,
            width: 90,
          ),

          const FloatingCloud(
            left: 250,
            top: 170,
            width: 70,
          ),

          const FloatingCloud(
            left: 80,
            top: 640,
            width: 85,
          ),

          /// Stars
          const FloatingStar(
            left: 50,
            top: 40,
            size: 18,
          ),

          const FloatingStar(
            left: 320,
            top: 120,
            size: 22,
          ),

          const FloatingStar(
            left: 170,
            top: 250,
            size: 16,
          ),

          const FloatingStar(
            left: 280,
            top: 720,
            size: 20,
          ),

          const FloatingStar(
            left: 90,
            top: 520,
            size: 18,
          ),

          /// Coins
          const FloatingCoin(
            left: 35,
            top: 340,
          ),

          const FloatingCoin(
            left: 300,
            top: 470,
          ),

          const FloatingCoin(
            left: 250,
            top: 650,
          ),

          const FloatingCoin(
            left: 70,
            top: 780,
          ),

          /// Trophy
          const FloatingTrophy(
            left: 40,
            top: 520,
          ),

          /// Child Screen
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 0,
                sigmaY: 0,
              ),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}