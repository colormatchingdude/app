import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/color_game.dart';
import '../widgets/color_display.dart';
import '../widgets/color_palette.dart';
import '../widgets/game_controls.dart';
import '../widgets/difficulty_selector.dart';
import '../constants/game_constants.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorGameModel = Provider.of<ColorGameModel>(context);
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Color Mixer Game',
          style: TextStyle(
            fontSize: isSmallScreen ? 18.0 : 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          DifficultySelector(),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                decoration: BoxDecoration(
                  color: kGameContainerColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Color Display Area (Your Mix and Target)
                    const ColorDisplay(),
                    
                    SizedBox(height: isSmallScreen ? 24.0 : 30.0),
                    
                    // Base Color Palette
                    const ColorPalette(),
                    
                    SizedBox(height: isSmallScreen ? 20.0 : 28.0),
                    
                    // Controls Area (Reset, Solution, Next buttons)
                    const GameControls(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
