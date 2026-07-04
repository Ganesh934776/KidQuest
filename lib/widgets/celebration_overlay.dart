import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class CelebrationOverlay extends StatelessWidget {
  final ConfettiController controller;

  const CelebrationOverlay({
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
          shouldLoop: false,
          emissionFrequency: 0.04,
          numberOfParticles: 30,
          gravity: 0.25,
          maxBlastForce: 35,
          minBlastForce: 15,
        ),
      ),
    );
  }
}