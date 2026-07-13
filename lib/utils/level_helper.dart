class LevelHelper {
  static const int xpPerLevel = 100;

  /// Current level
  static int getLevel(int xp) {
    return (xp ~/ xpPerLevel) + 1;
  }

  /// XP earned in current level
  static int getCurrentLevelXP(int xp) {
    return xp % xpPerLevel;
  }

  /// XP required for one level
  static int getRequiredXP(int level) {
    return xpPerLevel;
  }

  /// Total XP needed to reach next level
  static int nextLevelXP(int level) {
    return level * xpPerLevel;
  }

  /// Progress (0.0 - 1.0)
  static double getProgress(int xp) {
    return (xp % xpPerLevel) / xpPerLevel;
  }

  /// Alias for compatibility
  static double progress(int xp) {
    return getProgress(xp);
  }

  /// Remaining XP
  static int getRemainingXP(int xp) {
    return xpPerLevel - (xp % xpPerLevel);
  }

  static String getLevelName(int level) {
    if (level <= 2) return "Beginner";
    if (level <= 5) return "Explorer";
    if (level <= 8) return "Champion";
    if (level <= 12) return "Master";
    return "Legend";
  }
}