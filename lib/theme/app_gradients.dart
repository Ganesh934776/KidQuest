import 'package:flutter/material.dart';

class AppGradients {
  AppGradients._();

  static const primary = LinearGradient(
    colors: [
      Color(0xff6C63FF),
      Color(0xff5A8DEE),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const success = LinearGradient(
    colors: [
      Color(0xff34D399),
      Color(0xff10B981),
    ],
  );

  static const gold = LinearGradient(
    colors: [
      Color(0xffFFD54F),
      Color(0xffF59E0B),
    ],
  );
}