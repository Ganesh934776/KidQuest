class Pet {
  final String name;
  final int level;
  final int happiness;
  final int hunger;
  final int energy;

  const Pet({
    required this.name,
    required this.level,
    required this.happiness,
    required this.hunger,
    required this.energy,
  });

  factory Pet.fromXP(int xp) {
    return Pet(
      name: "Nibble",
      level: (xp ~/ 100) + 1,
      happiness: (50 + xp ~/ 5).clamp(0, 100),
      hunger: (100 - xp ~/ 8).clamp(0, 100),
      energy: (60 + xp ~/ 6).clamp(0, 100),
    );
  }
}