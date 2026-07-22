import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Large Screen Titles
  static const TextStyle headline = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
    letterSpacing: -0.5,
  );

  // Section Heading
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  // Card Title
  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  // Subtitle
  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    color: AppColors.textLight,
    height: 1.4,
  );

  // Button
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Small Caption
  static const TextStyle caption = TextStyle(
    fontSize: 13,
    color: AppColors.textLight,
  );

  // XP Numbers
  static const TextStyle xp = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  // Coins
  static const TextStyle coins = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.gold,
  );
}