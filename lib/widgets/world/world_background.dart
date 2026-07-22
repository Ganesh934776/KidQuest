import 'package:flutter/material.dart';

class WorldBackground extends StatelessWidget {
  const WorldBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff7ED6FF),
            Color(0xffBFEFFF),
            Color(0xffEAFBFF),
          ],
        ),
      ),
    );
  }
}