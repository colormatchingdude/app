import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/color_game.dart';
import '../constants/game_constants.dart';
import '../utils/color_utils.dart';

class ColorPalette extends StatelessWidget {
  const ColorPalette({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorGameModel = Provider.of<ColorGameModel>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    
    // Calculate how many colors per row based on screen size
    final colorsPerRow = screenWidth < 400 ? 3 : 4;
    
    // Only display the colors based on the current difficulty level
    final visibleBaseColors = colorGameModel.visibleBaseColors;
    
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: isSmallScreen ? 10 : 15,
      runSpacing: isSmallScreen ? 15 : 25,
      children: List.generate(visibleBaseColors, (index) {
        return ColorPaletteItem(
          color: baseColors[index]['color'],
          index: index,
          amount: colorGameModel.colorAmounts[index],
          totalAmount: colorGameModel.colorAmounts.fold(0, (sum, val) => sum + val),
          size: isSmallScreen ? 50.0 : 65.0,
        );
      }),
    );
  }
}

class ColorPaletteItem extends StatelessWidget {
  final Color color;
  final int index;
  final int amount;
  final int totalAmount;
  final double size;

  const ColorPaletteItem({
    Key? key,
    required this.color,
    required this.index,
    required this.amount,
    required this.totalAmount,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorGameModel = Provider.of<ColorGameModel>(context, listen: false);
    final textColor = ColorUtils.getTextColorForBackground(color);
    
    // Calculate percentage
    final percentage = totalAmount > 0 ? (amount / totalAmount) * 100 : 0;
    final percentageText = percentage > 0 ? '${percentage.round()}%' : '0%';
    final percentageColor = percentage > 0 ? Colors.white : Colors.grey.shade400;
    
    return SizedBox(
      width: size + 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Color circle button with amount displayed inside
          GestureDetector(
            onTap: () => colorGameModel.addColor(index),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '$amount',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ),
          
          // Percentage display
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              percentageText,
              style: TextStyle(
                fontSize: 12,
                color: percentageColor,
              ),
            ),
          ),
          
          // Minus button
          GestureDetector(
            onTap: amount > 0 
                ? () => colorGameModel.subtractColor(index) 
                : null,
            child: Container(
              width: 28,
              height: 28,
              margin: const EdgeInsets.only(top: 4.0),
              decoration: BoxDecoration(
                color: const Color(0xFF555555),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF666666),
                  width: 1.0,
                ),
                // Dim the button if disabled
                boxShadow: amount > 0 ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ] : null,
              ),
              child: Center(
                child: Text(
                  '-',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    // Make the text slightly transparent if disabled
                    opacity: amount > 0 ? 1.0 : 0.4,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Extension to allow opacity on Text
extension TextOpacity on Text {
  Text copy({double? opacity}) {
    if (opacity == null) return this;
    
    return Text(
      data ?? '',
      style: style?.copyWith(
        color: style?.color?.withOpacity(opacity),
      ) ?? TextStyle(color: Colors.black.withOpacity(opacity)),
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
    );
  }
}
