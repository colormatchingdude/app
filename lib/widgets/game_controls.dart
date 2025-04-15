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
              crossAxisAlignment: CrossAxisAlignment.stretch, // Make buttons full width
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
              spacing: 16.0, // Increase spacing between buttons
              runSpacing: 16.0,
              alignment: WrapAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 120.0, // Fixed width for the difficulty button
                  child: _buildDifficultyButton(context),
                ),
                SizedBox(
                  width: 120.0, // Fixed width for other buttons for consistency
                  child: _buildResetButton(),
                ),
                SizedBox(
                  width: 120.0,
                  child: _buildSolutionButton(),
                ),
                SizedBox(
                  width: 120.0,
                  child: _buildNextButton(),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  // New method to build the difficulty dropdown button
  Widget _buildDifficultyButton(BuildContext context) {
    // Create a button that matches other buttons but has dropdown functionality
    return Container(
      height: 48.0, // Fixed height to match other buttons
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.white, width: 1.0),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<DifficultyLevel>(
            value: currentDifficulty,
            onChanged: (value) {
              if (value != null) {
                onDifficultySelected(value);
              }
            },
            isExpanded: true,
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
            dropdownColor: Colors.black,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            ),
            iconSize: 24.0,
            alignment: Alignment.center,
          ),
        ),
      ),
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
        height: 40.0, // Fixed height for dropdown items
        alignment: Alignment.centerLeft,
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

  // Common button style for all buttons
  ButtonStyle get _commonButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: Colors.black, // Black background
    foregroundColor: Colors.white, // White text
    padding: const EdgeInsets.symmetric(
      horizontal: 24.0,
      vertical: 12.0,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
      side: const BorderSide(color: Colors.white, width: 1.0), // White border
    ),
    elevation: 0, // No shadow
  );
  
  Widget _buildResetButton() {
    return ElevatedButton(
      onPressed: onReset,
      style: _commonButtonStyle,
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
      style: _commonButtonStyle,
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
      style: _commonButtonStyle,
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