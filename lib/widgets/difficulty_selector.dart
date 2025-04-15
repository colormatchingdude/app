import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/color_game.dart';

class DifficultySelector extends StatefulWidget {
  const DifficultySelector({Key? key}) : super(key: key);

  @override
  State<DifficultySelector> createState() => _DifficultySelectorState();
}

class _DifficultySelectorState extends State<DifficultySelector> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colorGameModel = Provider.of<ColorGameModel>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    
    // Get difficulty display name with first letter capitalized
    String getDifficultyDisplayName(String difficulty) {
      return difficulty[0].toUpperCase() + difficulty.substring(1);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: PopupMenuButton<String>(
        onSelected: (String difficulty) {
          colorGameModel.setDifficulty(difficulty);
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'easy',
            child: Text(
              'Easy',
              style: TextStyle(
                color: colorGameModel.currentDifficulty == 'easy'
                    ? Theme.of(context).primaryColor
                    : Colors.black,
                fontWeight: colorGameModel.currentDifficulty == 'easy'
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: 'medium',
            child: Text(
              'Medium',
              style: TextStyle(
                color: colorGameModel.currentDifficulty == 'medium'
                    ? Theme.of(context).primaryColor
                    : Colors.black,
                fontWeight: colorGameModel.currentDifficulty == 'medium'
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: 'hard',
            child: Text(
              'Hard',
              style: TextStyle(
                color: colorGameModel.currentDifficulty == 'hard'
                    ? Theme.of(context).primaryColor
                    : Colors.black,
                fontWeight: colorGameModel.currentDifficulty == 'hard'
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        ],
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 10.0 : 15.0,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Difficulty',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSmallScreen ? 14.0 : 16.0,
                ),
              ),
              const SizedBox(width: 5.0),
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
                size: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
