import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedTitle extends StatelessWidget {
  const AnimatedTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        const Icon(
          Icons.emoji_events_rounded,
          size: 90,
          color: Colors.amber,
        ),

        const SizedBox(height: 20),

        Text(
          "KidQuest",
          style: GoogleFonts.poppins(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 10),

        AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [

            FadeAnimatedText(
              "Build Better Habits",
              textStyle: GoogleFonts.poppins(
                fontSize: 20,
                color: Colors.white70,
              ),
            ),

            FadeAnimatedText(
              "Earn Rewards",
              textStyle: GoogleFonts.poppins(
                fontSize: 20,
                color: Colors.white70,
              ),
            ),

            FadeAnimatedText(
              "Become a Champion!",
              textStyle: GoogleFonts.poppins(
                fontSize: 20,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ],
    );
  }
}