import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF4F46E5);
  static const Color secondary = Color(0xFF22C55E);
  static const Color accent = Color(0xFFF59E0B);
  static const Color background = Color(0xFFF8FAFC);
  static const Color card = Colors.white;

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: background,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),

    cardTheme: CardThemeData(
      color: card,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
  );
}