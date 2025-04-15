import 'package:flutter/material.dart';
import 'package:color_mixer_game/constants/app_colors.dart';

class GameControls extends StatelessWidget {
  final VoidCallback onReset;
  final VoidCallback onSolution;
  final VoidCallback onNextColor;

  const GameControls({
    Key? key,
    required this.onReset,
    required this.onSolution,
    required this.onNextColor,
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
                _buildResetButton(),
                const SizedBox(height: 12.0),
                _buildSolutionButton(),
                const SizedBox(height: 12.0),
                _buildNextButton(),
              ],
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
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