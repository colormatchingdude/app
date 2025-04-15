import 'dart:math';
import 'package:flutter/material.dart';

class ColorUtils {
  /// Calculate the match percentage between two colors
  static double calculateColorMatch(Color mixedColor, Color targetColor) {
    // Calculate the Euclidean distance between the colors in RGB space
    final diffR = targetColor.red - mixedColor.red;
    final diffG = targetColor.green - mixedColor.green;
    final diffB = targetColor.blue - mixedColor.blue;
    
    final distance = sqrt(diffR * diffR + diffG * diffG + diffB * diffB);
    
    // Maximum possible distance in RGB space
    const maxDistance = 441.67; // sqrt(3 * 255²)
    
    // Calculate match percentage (100% - normalized distance)
    final matchPercentage = max(0, 100 * (1 - distance / maxDistance));
    
    return matchPercentage;
  }

  /// Determine if a color is dark (for text contrast)
  static bool isDarkColor(Color color) {
    // Calculate relative luminance (per WCAG)
    final r = color.red / 255.0;
    final g = color.green / 255.0;
    final b = color.blue / 255.0;
    
    // Apply gamma correction approximation
    final rLinear = r <= 0.03928 ? r / 12.92 : pow((r + 0.055) / 1.055, 2.4);
    final gLinear = g <= 0.03928 ? g / 12.92 : pow((g + 0.055) / 1.055, 2.4);
    final bLinear = b <= 0.03928 ? b / 12.92 : pow((b + 0.055) / 1.055, 2.4);
    
    // Calculate luminance
    final luminance = 0.2126 * rLinear + 0.7152 * gLinear + 0.0722 * bLinear;
    
    return luminance < 0.5;
  }

  /// Get appropriate text color based on background color
  static Color getTextColorForBackground(Color backgroundColor) {
    return isDarkColor(backgroundColor) ? Colors.white : Colors.black;
  }
}