import 'package:flutter/material.dart';

/// Base colors available in the game
final List<Map<String, dynamic>> baseColors = [
  {'name': '#F52F0C', 'hex': '#F52F0C', 'color': const Color(0xFFF52F0C)},
  {'name': '#B2F711', 'hex': '#B2F711', 'color': const Color(0xFFB2F711)},
  {'name': '#0FF57A', 'hex': '#0FF57A', 'color': const Color(0xFF0FF57A)},
  {'name': '#1B07F0', 'hex': '#1B07F0', 'color': const Color(0xFF1B07F0)},
  {'name': '#FFFFFF', 'hex': '#FFFFFF', 'color': const Color(0xFFFFFFFF)},
  {'name': '#000000', 'hex': '#000000', 'color': const Color(0xFF000000)},
];

/// Difficulty settings
const Map<String, Map<String, dynamic>> difficultySettings = {
  'easy': {
    'numColors': {'min': 2, 'max': 3},
    'weightsRange': {'min': 1, 'max': 3},
    'visibleBaseColors': 4, // Show only 4 base colors
  },
  'medium': {
    'numColors': {'min': 2, 'max': 4},
    'weightsRange': {'min': 1, 'max': 5},
    'visibleBaseColors': 5, // Show 5 base colors
  },
  'hard': {
    'numColors': {'min': 3, 'max': 5},
    'weightsRange': {'min': 1, 'max': 7},
    'visibleBaseColors': 6, // Show all 6 base colors
  },
};

// Color theme values
const Color kAppBackgroundColor = Color(0xFFF0F0F0);
const Color kGameContainerColor = Color(0xFF444444);
const Color kResetButtonColor = Color(0xFFDC3545);
const Color kSolutionButtonColor = Color(0xFF17A2B8);
const Color kNextButtonColor = Color(0xFF007BFF);
const Color kTextColor = Color(0xFF333333);
