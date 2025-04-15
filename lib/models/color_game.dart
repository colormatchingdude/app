import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/game_constants.dart';
import '../utils/color_utils.dart';

class ColorGameModel extends ChangeNotifier {
  // Current difficulty level
  String _currentDifficulty = 'medium';
  
  // Color amounts for each base color
  List<int> _colorAmounts = [];
  
  // Target color components
  Color _targetColor = Colors.grey;
  
  // Target color ratios (for solution)
  List<int> _targetColorRatios = [];
  
  // Current mixed color
  Color _mixedColor = Colors.transparent;
  
  // Match percentage
  double _matchPercentage = 0.0;
  
  // Random number generator
  final Random _random = Random();
  
  // Getters
  String get currentDifficulty => _currentDifficulty;
  List<int> get colorAmounts => _colorAmounts;
  Color get targetColor => _targetColor;
  Color get mixedColor => _mixedColor;
  double get matchPercentage => _matchPercentage;
  List<int> get targetColorRatios => _targetColorRatios;
  
  // Number of visible base colors based on difficulty
  int get visibleBaseColors => 
      difficultySettings[_currentDifficulty]!['visibleBaseColors'] as int;
  
  // Constructor
  ColorGameModel() {
    // Initialize color amounts array with zeros
    _colorAmounts = List.filled(baseColors.length, 0);
    
    // Generate the first target color
    _generateTargetColor();
  }
  
  // Set difficulty level
  void setDifficulty(String difficulty) {
    if (difficultySettings.containsKey(difficulty)) {
      _currentDifficulty = difficulty;
      _resetGame();
      
      // Generate a new target color appropriate for this difficulty
      _generateTargetColor();
      
      notifyListeners();
    }
  }
  
  // Add a color amount
  void addColor(int colorIndex) {
    if (colorIndex >= 0 && colorIndex < _colorAmounts.length) {
      _colorAmounts[colorIndex]++;
      _updateMixedColor();
      notifyListeners();
    }
  }
  
  // Subtract a color amount
  void subtractColor(int colorIndex) {
    if (colorIndex >= 0 && colorIndex < _colorAmounts.length && _colorAmounts[colorIndex] > 0) {
      _colorAmounts[colorIndex]--;
      _updateMixedColor();
      notifyListeners();
    }
  }
  
  // Reset the game (clear all colors)
  void resetGame() {
    _resetGame();
    notifyListeners();
  }
  
  // Internal reset method
  void _resetGame() {
    _colorAmounts = List.filled(baseColors.length, 0);
    _mixedColor = Colors.transparent;
    _matchPercentage = 0.0;
  }
  
  // Generate next target color
  void nextTargetColor() {
    _resetGame();
    _generateTargetColor();
    notifyListeners();
  }
  
  // Show solution
  void showSolution() {
    _colorAmounts = List.from(_targetColorRatios);
    _updateMixedColor();
    notifyListeners();
  }
  
  // Generate a random target color
  void _generateTargetColor() {
    final difficulty = difficultySettings[_currentDifficulty]!;
    final numColorsRange = difficulty['numColors'] as Map<String, dynamic>;
    final weightsRange = difficulty['weightsRange'] as Map<String, dynamic>;
    final visibleColors = difficulty['visibleBaseColors'] as int;
    
    // Determine how many base colors to use for this target
    final numColors = _random.nextInt(
        numColorsRange['max'] - numColorsRange['min'] + 1) + 
        numColorsRange['min'];
    
    // Create a temporary list for target ratios
    final tempRatios = List.filled(baseColors.length, 0);
    
    // Choose random base colors and weights, only from the visible colors for this difficulty
    final availableIndices = List.generate(visibleColors, (i) => i);
    availableIndices.shuffle(_random);
    
    // Use only the first numColors indices
    for (int i = 0; i < numColors; i++) {
      final colorIndex = availableIndices[i];
      final weight = _random.nextInt(
          weightsRange['max'] - weightsRange['min'] + 1) + 
          weightsRange['min'];
      tempRatios[colorIndex] = weight;
    }
    
    // Store the target ratios for solution
    _targetColorRatios = List.from(tempRatios);
    
    // Create the list of colors and their amounts for mixing
    final colors = <Color>[];
    final amounts = <int>[];
    
    for (int i = 0; i < tempRatios.length; i++) {
      if (tempRatios[i] > 0) {
        colors.add(baseColors[i]['color']);
        amounts.add(tempRatios[i]);
      }
    }
    
    // Mix the colors to get the target
    _targetColor = ColorUtils.mixColors(colors, amounts);
  }
  
  // Update the mixed color based on current amounts
  void _updateMixedColor() {
    final visibleColors = difficultySettings[_currentDifficulty]!['visibleBaseColors'] as int;
    
    // Create lists of visible colors and their amounts
    final colors = <Color>[];
    final amounts = <int>[];
    
    // Only include the visible colors for the current difficulty
    for (int i = 0; i < visibleColors; i++) {
      if (_colorAmounts[i] > 0) {
        colors.add(baseColors[i]['color']);
        amounts.add(_colorAmounts[i]);
      }
    }
    
    // Mix the colors
    _mixedColor = ColorUtils.mixColors(colors, amounts);
    
    // Calculate the match percentage
    _calculateMatchPercentage();
  }
  
  // Calculate how closely the mixed color matches the target
  void _calculateMatchPercentage() {
    // If no colors added, match is 0
    final totalAmount = _colorAmounts.fold(0, (sum, amount) => sum + amount);
    if (totalAmount == 0) {
      _matchPercentage = 0.0;
      return;
    }
    
    _matchPercentage = ColorUtils.calculateMatchPercentage(_mixedColor, _targetColor);
  }
}
