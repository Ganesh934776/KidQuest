import 'package:flutter/material.dart';

class AppRadius {
  AppRadius._();

  static const xs = Radius.circular(8);
  static const sm = Radius.circular(12);
  static const md = Radius.circular(18);
  static const lg = Radius.circular(24);
  static const xl = Radius.circular(32);

  static const card = BorderRadius.all(lg);
  static const button = BorderRadius.all(Radius.circular(18));
}