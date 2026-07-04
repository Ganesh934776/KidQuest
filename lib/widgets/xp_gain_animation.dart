import 'package:flutter/material.dart';

class XPGainAnimation extends StatefulWidget {
  final int xp;

  const XPGainAnimation({
    super.key,
    required this.xp,
  });

  @override
  State<XPGainAnimation> createState() => _XPGainAnimationState();
}

class _XPGainAnimationState extends State<XPGainAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _opacity = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(_controller);

    _offset = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -2),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: FadeTransition(
        opacity: _opacity,
        child: SlideTransition(
          position: _offset,
          child: Text(
            "+${widget.xp} XP",
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
        ),
      ),
    );
  }
}