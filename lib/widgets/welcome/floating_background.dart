import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FloatingBackground extends StatelessWidget {
  const FloatingBackground({super.key});

  Widget bubble(
      double left,
      double top,
      double size,
      Color color,
      IconData icon,
      ) {
    return Positioned(
      left: left,
      top: top,
      child: CircleAvatar(
        radius: size,
        backgroundColor: color.withValues(alpha: .18),
        child: Icon(
          icon,
          color: color,
          size: size,
        ),
      )
          .animate(onPlay: (c) => c.repeat())
          .moveY(
        begin: 0,
        end: -20,
        duration: 2500.ms,
      )
          .then()
          .moveY(
        begin: -20,
        end: 0,
        duration: 2500.ms,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        bubble(
          20,
          120,
          30,
          Colors.yellow,
          Icons.star,
        ),

        bubble(
          280,
          220,
          28,
          Colors.pink,
          Icons.favorite,
        ),

        bubble(
          100,
          400,
          32,
          Colors.orange,
          Icons.emoji_events,
        ),

        bubble(
          330,
          520,
          28,
          Colors.green,
          Icons.auto_awesome,
        ),

        bubble(
          220,
          100,
          35,
          Colors.lightBlue,
          Icons.sports_esports,
        ),
      ],
    );
  }
}