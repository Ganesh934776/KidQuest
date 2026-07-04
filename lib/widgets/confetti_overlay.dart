import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiOverlay extends StatelessWidget {
  final ConfettiController controller;

  const ConfettiOverlay({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConfettiWidget(
          confettiController: controller,
          blastDirectionality:
              BlastDirectionality.explosive,
          emissionFrequency: 0.05,
          numberOfParticles: 30,
          gravity: 0.25,
          shouldLoop: false,
          maxBlastForce: 30,
          minBlastForce: 10,
        ),
      ),
    );
  }
}