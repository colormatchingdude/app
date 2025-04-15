import 'package:flutter/material.dart';
import 'package:color_mixer_game/constants/app_colors.dart';
import 'package:color_mixer_game/utils/color_utils.dart';

class ColorPalette extends StatelessWidget {
  final int visibleColorsCount;
  final List<int> colorAmounts;
  final List<double> colorPercentages;
  final Function(int) onColorAdd;
  final Function(int) onColorRemove;

  const ColorPalette({
    Key? key,
    required this.visibleColorsCount,
    required this.colorAmounts,
    required this.colorPercentages,
    required this.onColorAdd,
    required this.onColorRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      alignment: WrapAlignment.center,
      children: List.generate(
        visibleColorsCount,
        (index) => _buildColorItem(index),
      ),
    );
  }

  Widget _buildColorItem(int index) {
    final baseColor = AppColors.baseColors[index];
    final textColor = ColorUtils.getTextColorForBackground(baseColor.color);
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Color Circle Button
        GestureDetector(
          onTap: () => onColorAdd(index),
          child: Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: baseColor.color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 2),
                  blurRadius: 4.0,
                ),
              ],
            ),
            child: Center(
              child: Text(
                '${colorAmounts[index]}',
                style: TextStyle(
                  color: textColor.withOpacity(0.7),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 4.0),
        
        // Percentage Text
        Text(
          '${colorPercentages[index].toInt()}%',
          style: TextStyle(
            color: colorPercentages[index] > 0
                ? Colors.white
                : Colors.white.withOpacity(0.6),
            fontSize: 14.0,
          ),
        ),
        
        const SizedBox(height: 4.0),
        
        // Minus Button
        ElevatedButton(
          onPressed: colorAmounts[index] > 0
              ? () => onColorRemove(index)
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF555555),
            foregroundColor: Colors.white,
            minimumSize: const Size(28, 28),
            padding: EdgeInsets.zero,
            shape: const CircleBorder(),
            disabledBackgroundColor: const Color(0xFF555555).withOpacity(0.4),
          ),
          child: const Icon(Icons.remove, size: 16.0),
        ),
      ],
    );
  }
}