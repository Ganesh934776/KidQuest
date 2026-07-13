import 'package:flutter/material.dart';

class AnimatedQuickActionCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const AnimatedQuickActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  State<AnimatedQuickActionCard> createState() =>
      _AnimatedQuickActionCardState();
}

class _AnimatedQuickActionCardState
    extends State<AnimatedQuickActionCard> {

  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.identity()
  ..translateByDouble(
    0,hover ? -6 : 0,
    0,
    1,
  ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: .18),
                blurRadius: hover ? 20 : 10,
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor:
                    widget.color.withValues(alpha: .12),
                child: Icon(
                  widget.icon,
                  color: widget.color,
                  size: 30,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}