import 'package:flutter/material.dart';

class AnimatedStatCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const AnimatedStatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  State<AnimatedStatCard> createState() =>
      _AnimatedStatCardState();
}

class _AnimatedStatCardState
    extends State<AnimatedStatCard> {

  bool hovering = false;

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: MouseRegion(
        onEnter: (_) => setState(() => hovering = true),
        onExit: (_) => setState(() => hovering = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),

          transform: Matrix4.identity()
  ..scaleByDouble(
    hovering ? 1.03 : 1.0,
    hovering ? 1.03 : 1.0,
    1,
    1,
  ),

          padding: const EdgeInsets.all(18),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),

            gradient: LinearGradient(
              colors: [
                widget.color,
                widget.color.withValues(alpha: 0.75),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),

            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: 0.30),
                blurRadius: hovering ? 20 : 10,
                offset: const Offset(0, 8),
              )
            ],
          ),

          child: Column(
            children: [

              CircleAvatar(
                radius: 26,
                backgroundColor:
                    Colors.white.withValues(alpha: 0.18),

                child: Icon(
                  widget.icon,
                  color: Colors.white,
                  size: 28,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                widget.value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}