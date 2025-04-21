import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:color_mixer_game/widgets/help_dialog.dart';

const double globalAspectRatio = 0.5;

class ColorDisplay extends StatefulWidget {
  final Color yourMixColor;
  final Color targetColor;
  final double matchPercentage;
  final bool showSuccessMessage;

  const ColorDisplay({
    Key? key,
    required this.yourMixColor,
    required this.targetColor,
    required this.matchPercentage,
    required this.showSuccessMessage,
  }) : super(key: key);

  @override
  State<ColorDisplay> createState() => _ColorDisplayState();
}

class _ColorDisplayState extends State<ColorDisplay> {
  late ConfettiController _confettiController;
  bool _previousSuccessState = false;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void didUpdateWidget(ColorDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If success message just became visible, play the confetti animation
    if (widget.showSuccessMessage && !_previousSuccessState) {
      _confettiController.play();
    }

    _previousSuccessState = widget.showSuccessMessage;
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Widget _buildHelpDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Help'),
      content: const Text('This is a help dialog.'),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main content
        Row(
          children: [
            // Your Mix Display
            Expanded(
              child: AspectRatio(
                aspectRatio: globalAspectRatio,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.yourMixColor == Colors.transparent
                        ? null
                        : widget.yourMixColor,
                    // Use a gradient for checkerboard pattern when transparent
                    gradient: widget.yourMixColor == Colors.transparent
                        ? LinearGradient(
                            colors: [
                              Colors.grey.withOpacity(0.2),
                              Colors.grey.withOpacity(0.1),
                            ],
                            tileMode: TileMode.repeated,
                            stops: const [0.0, 0.5],
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
                            'Match: ${widget.matchPercentage.toStringAsFixed(1)}%',
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Target Color Display
            Expanded(
              child: AspectRatio(
                aspectRatio: globalAspectRatio,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.targetColor,
                  ),
                  child: Stack(
                    children: [
                      Center(
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
                      Positioned(
                        top: 8.0,
                        right: 8.0,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.6),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 18,
                            icon: const Icon(Icons.help_outline),
                            color: const Color(0xFF333333),
                            onPressed: () {
                              // Handle help button press
                              showDialog(
                                context: context,
                                builder: (context) => const HelpDialog(),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        // Confetti celebration overlay
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive, // Blast in all directions
            emissionFrequency: 0.05, // How often it emits particles
            numberOfParticles: 20, // Number of particles to emit
            maxBlastForce: 20, // Max blast force
            minBlastForce: 5, // Min blast force
            gravity: 0.2, // Gravity of particles

            // Use different colors for confetti pieces
            colors: const [
              Colors.red,
              Colors.blue,
              Colors.green,
              Colors.yellow,
              Colors.purple,
              Colors.orange,
            ],
          ),
        ),
      ],
    );
  }
}