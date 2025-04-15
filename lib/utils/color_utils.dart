import 'dart:math';
import 'package:flutter/material.dart';

/// Utility class for color-related operations used in the game
class ColorUtils {
  /// Converts a hex color string to a Color object
  static Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    }
    return Colors.black;
  }

  /// Converts a Color object to a hex string
  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2, 8).toUpperCase()}';
  }

  /// Converts RGB values to a Color object
  static Color rgbToColor(int r, int g, int b) {
    return Color.fromRGBO(
      r.clamp(0, 255),
      g.clamp(0, 255),
      b.clamp(0, 255),
      1.0,
    );
  }

  /// Extracts RGB values from a Color object
  static Map<String, int> colorToRgb(Color color) {
    return {
      'r': color.red,
      'g': color.green,
      'b': color.blue,
    };
  }

  /// Calculate the color distance between two colors (for match percentage)
  static double calculateColorDistance(Color color1, Color color2) {
    final diffR = color1.red - color2.red;
    final diffG = color1.green - color2.green;
    final diffB = color1.blue - color2.blue;
    return sqrt(diffR * diffR + diffG * diffG + diffB * diffB);
  }

  /// Calculate the match percentage between two colors
  static double calculateMatchPercentage(Color color1, Color color2) {
    final distance = calculateColorDistance(color1, color2);
    final maxDistance = sqrt(3 * pow(255, 2)); // Maximum possible distance
    final match = max(0, 100 * (1 - distance / maxDistance));
    return match;
  }

  /// Determines if text on a given background color should be light or dark
  static Color getTextColorForBackground(Color backgroundColor) {
    // Convert the color to grayscale and check its luminance
    final luminance = (0.299 * backgroundColor.red + 
                      0.587 * backgroundColor.green + 
                      0.114 * backgroundColor.blue) / 255;
    
    // Return white for dark backgrounds, black for light ones
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  /// Mix colors based on their ratios
  static Color mixColors(List<Color> colors, List<int> amounts) {
    if (colors.isEmpty || amounts.isEmpty || colors.length != amounts.length) {
      return Colors.transparent;
    }

    int totalAmount = amounts.fold(0, (sum, amount) => sum + amount);
    if (totalAmount == 0) {
      return Colors.transparent;
    }

    double mixedR = 0, mixedG = 0, mixedB = 0;

    for (int i = 0; i < colors.length; i++) {
      if (amounts[i] > 0) {
        final proportion = amounts[i] / totalAmount;
        mixedR += colors[i].red * proportion;
        mixedG += colors[i].green * proportion;
        mixedB += colors[i].blue * proportion;
      }
    }

    return Color.fromRGBO(
      mixedR.round().clamp(0, 255),
      mixedG.round().clamp(0, 255),
      mixedB.round().clamp(0, 255),
      1.0,
    );
  }
}
