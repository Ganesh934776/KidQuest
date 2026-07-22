import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand Colors
  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFF7ED957);

  static const Color gold = Color(0xFFFFC857);
  static const Color danger = Color(0xFFFF6B6B);

  // Background
  static const Color background = Color(0xFFF6F8FF);
  static const Color card = Colors.white;

  // Shadow
  static const Color cardShadow = Color(0x1A000000);

  // Text
  static const Color textDark = Color(0xFF1D1D1D);
  static const Color textLight = Color(0xFF757575);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFF6C63FF),
      Color(0xFF8E7BFF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}