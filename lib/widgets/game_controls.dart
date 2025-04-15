import 'package:flutter/material.dart';
import 'package:color_mixer_game/constants/app_colors.dart';
import 'package:color_mixer_game/constants/difficulty_settings.dart';

class GameControls extends StatelessWidget {
  final VoidCallback onReset;
  final VoidCallback onSolution;
  final VoidCallback onNextColor;
  // Added difficulty parameters
  final DifficultyLevel currentDifficulty;
  final Function(DifficultyLevel) onDifficultySelected;

  const GameControls({
    Key? key,
    required this.onReset,
    required this.onSolution,
    required this.onNextColor,
    required this.currentDifficulty,
    required this.onDifficultySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 1.0,
          ),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Use column layout for narrow screens, row for wider screens
          final isNarrow = constraints.maxWidth < 500;
          
          if (isNarrow) {
            return Column(
              children: [
                _buildDifficultyButton(context),
                const SizedBox(height: 12.0),
                _buildResetButton(),
                const SizedBox(height: 12.0),
                _buildSolutionButton(),
                const SizedBox(height: 12.0),
                _buildNextButton(),
              ],
            );
          } else {
            return Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              alignment: WrapAlignment.spaceEvenly,
              children: [
                _buildDifficultyButton(context),
                _buildResetButton(),
                _buildSolutionButton(),
                _buildNextButton(),
              ],
            );
          }
        },
      ),
    );
  }

  // New method to build the difficulty dropdown button
  Widget _buildDifficultyButton(BuildContext context) {
    return DropdownButton<DifficultyLevel>(
      value: currentDifficulty,
      onChanged: (value) {
        if (value != null) {
          onDifficultySelected(value);
        }
      },
      underline: Container(),
      items: [
        _buildDropdownItem(DifficultyLevel.easy, 'Easy'),
        _buildDropdownItem(DifficultyLevel.medium, 'Medium'),
        _buildDropdownItem(DifficultyLevel.hard, 'Hard'),
      ],
      style: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      dropdownColor: const Color(0xFF007BFF),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      isDense: true,
      borderRadius: BorderRadius.circular(5.0),
    );
  }

  // Helper method to build dropdown items
  DropdownMenuItem<DifficultyLevel> _buildDropdownItem(
    DifficultyLevel difficulty, 
    String text
  ) {
    return DropdownMenuItem<DifficultyLevel>(
      value: difficulty,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 12.0,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildResetButton() {
    return ElevatedButton(
      onPressed: onReset,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.resetButtonColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 12.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: const Text(
        'Reset',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSolutionButton() {
    return ElevatedButton(
      onPressed: onSolution,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.solutionButtonColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 12.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: const Text(
        'Solution',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: onNextColor,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryButtonColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 12.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      child: const Text(
        'Next',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}