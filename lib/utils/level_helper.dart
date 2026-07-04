class LevelHelper {
  /// Current Level
  static int getLevel(int xp) {
    if (xp < 100) return 1;
    if (xp < 250) return 2;
    if (xp < 450) return 3;
    if (xp < 700) return 4;
    if (xp < 1000) return 5;
    return 6 + ((xp - 1000) ~/ 500);
  }

  /// XP needed for current level
  static int currentLevelXP(int level) {
    switch (level) {
      case 1:
        return 0;
      case 2:
        return 100;
      case 3:
        return 250;
      case 4:
        return 450;
      case 5:
        return 700;
      case 6:
        return 1000;
      default:
        return 1000 + ((level - 6) * 500);
    }
  }

  /// XP needed for next level
  static int nextLevelXP(int level) {
    switch (level) {
      case 1:
        return 100;
      case 2:
        return 250;
      case 3:
        return 450;
      case 4:
        return 700;
      case 5:
        return 1000;
      default:
        return currentLevelXP(level + 1);
    }
  }

  /// Progress (0.0 - 1.0)
  static double progress(int xp) {
    final level = getLevel(xp);

    final current = currentLevelXP(level);
    final next = nextLevelXP(level);

    return (xp - current) / (next - current);
  }
}