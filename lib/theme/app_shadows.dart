import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  static List<BoxShadow> card = [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];

  static List<BoxShadow> floating = [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 30,
      offset: Offset(0, 15),
    ),
  ];
}