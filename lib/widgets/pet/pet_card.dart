import 'package:flutter/material.dart';
import 'package:kidquest/models/pet.dart';

class PetCard extends StatelessWidget {
  final Pet pet;

  const PetCard({
    super.key,
    required this.pet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xffFF9966),
            Color(0xffFF5E62),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [

          const Text(
            "🐉",
            style: TextStyle(fontSize: 70),
          ),

          const SizedBox(height: 10),

          Text(
            pet.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            "Level ${pet.level}",
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 20),

          _bar(
            "❤️ Happiness",
            pet.happiness,
            Colors.green,
          ),

          const SizedBox(height: 12),

          _bar(
            "⚡ Energy",
            pet.energy,
            Colors.amber,
          ),

          const SizedBox(height: 12),

          _bar(
            "🍖 Hunger",
            pet.hunger,
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _bar(
    String title,
    int value,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "$title   $value%",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 6),

        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: value / 100,
            minHeight: 10,
            backgroundColor: Colors.white24,
            color: color,
          ),
        ),
      ],
    );
  }
}