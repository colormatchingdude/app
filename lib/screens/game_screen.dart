import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:color_mixer_game/constants/app_colors.dart';
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
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: AppColors.gameContainerColor,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Top: Color Display (fixed size)
              ColorDisplay(
                yourMixColor: colorGame.currentMixedColor,
                targetColor: colorGame.targetColor,
                matchPercentage: colorGame.matchPercentage,
                showSuccessMessage: colorGame.showSuccessMessage,
              ),

              const SizedBox(height: 16.0),

              // Spacer: absorbs available vertical space between top and bottom
              const Spacer(),

              // Middle: Color Palette
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

              // Bottom: Game Controls
              GameControls(
                onReset: () => colorGame.resetMix(),
                onSolution: () => colorGame.showSolution(),
                onNextColor: () => colorGame.generateTargetColor(),
                currentDifficulty: colorGame.currentDifficulty,
                onDifficultySelected: (difficulty) =>
                    colorGame.setDifficulty(difficulty),
              ),
            ],
          ),
        ),
      ),
    );
  }
}