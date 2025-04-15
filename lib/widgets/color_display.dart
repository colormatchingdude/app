import 'package:flutter/material.dart';

class ColorDisplay extends StatelessWidget {
  final Color yourMixColor;
  final Color targetColor;
  final double matchPercentage;
  final bool showSuccessMessage;
  final bool showSolutionMessage;

  const ColorDisplay({
    Key? key,
    required this.yourMixColor,
    required this.targetColor,
    required this.matchPercentage,
    required this.showSuccessMessage,
    required this.showSolutionMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Your Mix Display
        Expanded(
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: yourMixColor == Colors.transparent 
                    ? null 
                    : yourMixColor,
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, 1),
                    blurRadius: 3.0,
                  ),
                ],
                // Pattern for transparent mix
                image: yourMixColor == Colors.transparent
                    ? const DecorationImage(
                        image: AssetImage('assets/images/transparent_bg.png'),
                        repeat: ImageRepeat.repeat,
                      )
                    : null,
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 15.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Your Mix',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        'Match: ${matchPercentage.toStringAsFixed(1)}%',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFF333333),
                        ),
                      ),
                      if (showSuccessMessage) ...[
                        const SizedBox(height: 5.0),
                        const Text(
                          'Great Job!',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF28A745),
                          ),
                        ),
                      ],
                      if (showSolutionMessage) ...[
                        const SizedBox(height: 5.0),
                        const Text(
                          'Solution Applied',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF007BFF),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        
        const SizedBox(width: 16.0),
        
        // Target Color Display
        Expanded(
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: targetColor,
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, 1),
                    blurRadius: 3.0,
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 15.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: const Text(
                    'Target',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}