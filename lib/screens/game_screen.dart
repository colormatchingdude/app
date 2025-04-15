import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:color_mixer_game/constants/app_colors.dart';
import 'package:color_mixer_game/constants/difficulty_settings.dart';
import 'package:color_mixer_game/models/color_game.dart';
import 'package:color_mixer_game/widgets/color_display.dart';
import 'package:color_mixer_game/widgets/color_palette.dart';
import 'package:color_mixer_game/widgets/game_controls.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorGame = Provider.of<ColorGame>(context);
    
    return Scaffold(
      // Removed AppBar
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Game title at the top
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 24.0),
                  child: Text(
                    'Color Mixer Game',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
                
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: AppColors.gameContainerColor,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        offset: const Offset(0, 4),
                        blurRadius: 12.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Color Display Section
                      ColorDisplay(
                        yourMixColor: colorGame.currentMixedColor,
                        targetColor: colorGame.targetColor,
                        matchPercentage: colorGame.matchPercentage,
                        showSuccessMessage: colorGame.showSuccessMessage,
                        showSolutionMessage: colorGame.showSolutionMessage,
                      ),
                      
                      const SizedBox(height: 24.0),
                      
                      // Color Palette Section
                      ColorPalette(
                        visibleColorsCount: colorGame.visibleColorsCount,
                        colorAmounts: colorGame.colorAmounts,
                        colorPercentages: List.generate(
                          AppColors.baseColors.length, 
                          (i) => colorGame.getColorPercentage(i),
                        ),
                        onColorAdd: (index) => colorGame.addColor(index),
                        onColorRemove: (index) => colorGame.removeColor(index),
                      ),
                      
                      const SizedBox(height: 24.0),
                      
                      // Game Controls Section with difficulty button
                      GameControls(
                        onReset: () => colorGame.resetMix(),
                        onSolution: () => colorGame.showSolution(),
                        onNextColor: () => colorGame.generateTargetColor(),
                        // Added difficulty info
                        currentDifficulty: colorGame.currentDifficulty,
                        onDifficultySelected: (difficulty) => colorGame.setDifficulty(difficulty),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}