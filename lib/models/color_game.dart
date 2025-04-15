import 'dart:math';
import 'package:flutter/material.dart';
import 'package:color_mixer_game/constants/app_colors.dart';
import 'package:color_mixer_game/constants/difficulty_settings.dart';
import 'package:color_mixer_game/utils/color_utils.dart';

class ColorGame extends ChangeNotifier {
  // Current difficulty level
  DifficultyLevel _currentDifficulty = DifficultyLevel.medium;
  DifficultyLevel get currentDifficulty => _currentDifficulty;

  // Base colors and amounts
  final List<int> _colorAmounts = List<int>.filled(AppColors.baseColors.length, 0);
  List<int> get colorAmounts => List<int>.from(_colorAmounts);

  // Target color and ratios
  Color _targetColor = Colors.grey;
  Color get targetColor => _targetColor;

  List<int> _targetColorRatios = [];
  List<int> get targetColorRatios => List<int>.from(_targetColorRatios);

  // Current match percentage
  double _matchPercentage = 0;
  double get matchPercentage => _matchPercentage;

  // Success message flag
  bool _showSuccessMessage = false;
  bool get showSuccessMessage => _showSuccessMessage;

  // Solution message flag
  bool _showSolutionMessage = false;
  bool get showSolutionMessage => _showSolutionMessage;

  // Current mixed color
  Color _currentMixedColor = Colors.transparent;
  Color get currentMixedColor => _currentMixedColor;

  // Constructor - initialize with a new target color
  ColorGame() {
    generateTargetColor();
  }

  // Change difficulty level
  void setDifficulty(DifficultyLevel difficulty) {
    _currentDifficulty = difficulty;
    resetMix();
    generateTargetColor();
    notifyListeners();
  }

  // Add color
  void addColor(int index) {
    if (index >= 0 && index < _colorAmounts.length) {
      _colorAmounts[index]++;
      _updateMixedColor();
      notifyListeners();
    }
  }

  // Remove color
  void removeColor(int index) {
    if (index >= 0 && index < _colorAmounts.length && _colorAmounts[index] > 0) {
      _colorAmounts[index]--;
      _updateMixedColor();
      notifyListeners();
    }
  }

  // Reset the mix
  void resetMix() {
    for (int i = 0; i < _colorAmounts.length; i++) {
      _colorAmounts[i] = 0;
    }
    _currentMixedColor = Colors.transparent;
    _matchPercentage = 0;
    _showSuccessMessage = false;
    _showSolutionMessage = false;
    notifyListeners();
  }

  // Generate a new target color
  void generateTargetColor() {
    resetMix();
    
    final settings = DifficultySettings.getSettings(_currentDifficulty);
    
    // Reset target color ratios
    _targetColorRatios = List<int>.filled(AppColors.baseColors.length, 0);
    
    // Select random number of colors to use
    final Random random = Random();
    final int numColorsToUse = settings.minColors + 
                              random.nextInt(settings.maxColors - settings.minColors + 1);
    
    // Available colors for current difficulty
    final int availableColors = settings.visibleBaseColors;
    
    // Randomly pick which colors to use
    final List<int> colorIndices = [];
    while (colorIndices.length < numColorsToUse) {
      final int index = random.nextInt(availableColors);
      if (!colorIndices.contains(index)) {
        colorIndices.add(index);
      }
    }
    
    // Assign random weights
    int totalWeight = 0;
    for (final index in colorIndices) {
      final int weight = settings.minWeights + 
                        random.nextInt(settings.maxWeights - settings.minWeights + 1);
      _targetColorRatios[index] = weight;
      totalWeight += weight;
    }
    
    // Calculate mixed color
    double r = 0, g = 0, b = 0;
    for (int i = 0; i < _targetColorRatios.length; i++) {
      if (_targetColorRatios[i] > 0) {
        final color = AppColors.baseColors[i].color;
        final proportion = _targetColorRatios[i] / totalWeight;
        r += color.red * proportion;
        g += color.green * proportion;
        b += color.blue * proportion;
      }
    }
    
    _targetColor = Color.fromRGBO(r.round(), g.round(), b.round(), 1.0);
    notifyListeners();
  }

  // Show solution
  void showSolution() {
    // Copy target ratios to current amounts
    for (int i = 0; i < _targetColorRatios.length; i++) {
      _colorAmounts[i] = _targetColorRatios[i];
    }
    
    _updateMixedColor();
    _showSolutionMessage = true;
    
    // Hide solution message after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      _showSolutionMessage = false;
      notifyListeners();
    });
    
    notifyListeners();
  }

  // Update mixed color and match percentage
  void _updateMixedColor() {
    int totalAmount = _colorAmounts.fold(0, (sum, amount) => sum + amount);
    
    if (totalAmount == 0) {
      _currentMixedColor = Colors.transparent;
      _matchPercentage = 0;
      _showSuccessMessage = false;
      return;
    }
    
    // Calculate mixed color
    double r = 0, g = 0, b = 0;
    for (int i = 0; i < _colorAmounts.length; i++) {
      if (_colorAmounts[i] > 0) {
        final color = AppColors.baseColors[i].color;
        final proportion = _colorAmounts[i] / totalAmount;
        r += color.red * proportion;
        g += color.green * proportion;
        b += color.blue * proportion;
      }
    }
    
    _currentMixedColor = Color.fromRGBO(r.round(), g.round(), b.round(), 1.0);
    
    // Calculate match percentage
    _matchPercentage = ColorUtils.calculateColorMatch(
      _currentMixedColor, 
      _targetColor
    );
    
    // Show success message if match is 99% or higher
    _showSuccessMessage = _matchPercentage >= 99;
  }

  // Get number of visible colors based on difficulty
  int get visibleColorsCount {
    return DifficultySettings.getSettings(_currentDifficulty).visibleBaseColors;
  }

  // Get percentage for a specific color
  double getColorPercentage(int index) {
    final totalAmount = _colorAmounts.fold(0, (sum, amount) => sum + amount);
    if (totalAmount == 0 || _colorAmounts[index] == 0) {
      return 0;
    }
    return (_colorAmounts[index] / totalAmount) * 100;
  }
}