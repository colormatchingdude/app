import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/color_game.dart';

class ColorDisplay extends StatelessWidget {
  const ColorDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorGameModel = Provider.of<ColorGameModel>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final boxSize = (screenWidth < 600) 
        ? ((screenWidth - 80) / 2)  // Smaller screens
        : 180.0;                   // Larger screens
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Your Mix box
        ColorBox(
          title: 'Your Mix',
          color: colorGameModel.mixedColor,
          matchPercentage: colorGameModel.matchPercentage,
          isTarget: false,
          size: boxSize,
        ),
        
        // Small spacing between boxes
        const SizedBox(width: 16),
        
        // Target Color box
        ColorBox(
          title: 'Target',
          color: colorGameModel.targetColor,
          isTarget: true,
          size: boxSize,
        ),
      ],
    );
  }
}

class ColorBox extends StatelessWidget {
  final String title;
  final Color color;
  final bool isTarget;
  final double? matchPercentage;
  final double size;

  const ColorBox({
    Key? key,
    required this.title,
    required this.color,
    required this.isTarget,
    this.matchPercentage,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
        // For 'Your Mix', handle transparency with a checkered pattern when no color
        color: (isTarget || color != Colors.transparent) ? color : null,
      ),
      child: Stack(
        children: [
          // Checkerboard pattern for transparent "Your Mix"
          if (!isTarget && color == Colors.transparent)
            CustomPaint(
              size: Size(size, size),
              painter: CheckerboardPainter(),
            ),
            
          // Label and match percentage overlay
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 15.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xDD000000),
                    ),
                  ),
                  if (!isTarget && matchPercentage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'Match: ${matchPercentage!.toStringAsFixed(1)}%',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xDD000000),
                        ),
                      ),
                    ),
                    
                  // Show "Great Job!" message when match is over 99%
                  if (!isTarget && matchPercentage != null && matchPercentage! >= 99)
                    const Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        'Great Job!',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF28A745),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter to create a checkerboard pattern for transparent color
class CheckerboardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const squareSize = 20.0;
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;
    
    for (int i = 0; i < (size.width / squareSize).ceil(); i++) {
      for (int j = 0; j < (size.height / squareSize).ceil(); j++) {
        if ((i + j) % 2 == 0) {
          canvas.drawRect(
            Rect.fromLTWH(
              i * squareSize, 
              j * squareSize, 
              squareSize, 
              squareSize
            ),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
