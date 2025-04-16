import 'package:flutter/material.dart';
import 'package:color_mixer_game/constants/difficulty_settings.dart';

class DifficultySelector extends StatelessWidget {
  final DifficultyLevel currentDifficulty;
  final Function(DifficultyLevel) onDifficultySelected;

  const DifficultySelector({
    Key? key,
    required this.currentDifficulty,
    required this.onDifficultySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<DifficultyLevel>(
      onSelected: onDifficultySelected,
      itemBuilder: (context) => [
        _buildMenuItem(context, DifficultyLevel.easy, 'Easy'),
        _buildMenuItem(context, DifficultyLevel.medium, 'Okay'),
        _buildMenuItem(context, DifficultyLevel.hard, 'OMG'),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _getDifficultyText(),
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4.0),
            const Icon(
              Icons.arrow_drop_down,
              size: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<DifficultyLevel> _buildMenuItem(
    BuildContext context,
    DifficultyLevel level,
    String text,
  ) {
    return PopupMenuItem<DifficultyLevel>(
      value: level,
      child: Row(
        children: [
          if (currentDifficulty == level)
            const Icon(
              Icons.check,
              size: 18.0,
              color: Colors.blue,
            ),
          if (currentDifficulty == level)
            const SizedBox(width: 8.0),
          Text(text),
        ],
      ),
    );
  }

  String _getDifficultyText() {
    switch (currentDifficulty) {
      case DifficultyLevel.easy:
        return 'Easy';
      case DifficultyLevel.medium:
        return 'Okay';
      case DifficultyLevel.hard:
        return 'OMG';
      default:
        return 'Easy';
    }
  }
}