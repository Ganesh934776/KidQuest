import 'package:flutter/material.dart';

class XPGainWidget extends StatelessWidget {
  final int xp;

  const XPGainWidget({
    super.key,
    required this.xp,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 18,
          ),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            "+$xp XP",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}