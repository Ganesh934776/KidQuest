import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ConfettiOverlay extends StatefulWidget {
  final Widget child;

  const ConfettiOverlay({
    super.key,
    required this.child,
  });

  @override
  State<ConfettiOverlay> createState() =>
      _ConfettiOverlayState();
}

class _ConfettiOverlayState extends State<ConfettiOverlay> {
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  void play() {
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,

        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _controller,
            blastDirection: pi / 2,
            maxBlastForce: 20,
            minBlastForce: 8,
            emissionFrequency: 0.05,
            numberOfParticles: 30,
            gravity: 0.3,
          ),
        ),
      ],
    );
  }
}