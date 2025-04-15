import 'package:flutter/material.dart';

class AppColors {
  static const baseColors = [
    BaseColor(name: 'Red', hex: 0xFFF52F0C),
    BaseColor(name: 'Green', hex: 0xFFB2F711),
    BaseColor(name: 'Teal', hex: 0xFF0FF57A),
    BaseColor(name: 'Blue', hex: 0xFF1B07F0),
    BaseColor(name: 'White', hex: 0xFFFFFFFF),
    BaseColor(name: 'Black', hex: 0xFF000000),
  ];

  static const backgroundColor = Color(0xFFF0F0F0);
  static const appBarColor = Color(0xFF333333);
  static const gameContainerColor = Color(0xFF444444);
  static const primaryButtonColor = Color(0xFF007BFF);
  static const resetButtonColor = Color(0xFFDC3545);
  static const solutionButtonColor = Color(0xFF17A2B8);
}

class BaseColor {
  final String name;
  final int hex;

  const BaseColor({
    required this.name,
    required this.hex,
  });

  Color get color => Color(hex);
}