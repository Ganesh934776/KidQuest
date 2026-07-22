import 'package:flutter/material.dart';

class NibbleCard extends StatelessWidget {
  final int level;
  final int happiness;
  final int energy;
  final String message;

  const NibbleCard({
    super.key,
    required this.level,
    required this.happiness,
    required this.energy,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xff6C63FF),
            Color(0xff8E85FF),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [

          const Text(
            "🐉",
            style: TextStyle(fontSize: 64),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                const Text(
                  "Nibble",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "Level $level",
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 10),

                LinearProgressIndicator(
                  value: happiness / 100,
                  minHeight: 8,
                  borderRadius:
                      BorderRadius.circular(20),
                ),

                const SizedBox(height: 6),

                Text(
                  "Happiness $happiness%",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}