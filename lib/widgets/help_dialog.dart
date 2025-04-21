
import 'package:flutter/material.dart';

class HelpDialog extends StatelessWidget {
  const HelpDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black.withOpacity(0.9),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 400),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'How to Play',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Goal:\nMix colors to match the target color shown at the top of the screen. Get as close as possible to achieve a high match percentage!',
                      style: TextStyle(color: Colors.white, height: 1.5),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'How to Mix Colors:\n• Tap on the colored circles to add colors to your mix.\n• Use the minus buttons to remove colors.\n• The percentage below a circle shows how much of that color is in your mix.',
                      style: TextStyle(color: Colors.white, height: 1.5),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Controls:\n• Reset: Clear your current mix and start over.\n• Hint: See the correct portions for some of the colors. \n• Next: Get a new target color to match.\n• Difficulty: Choose between Easy, Okay, and OMG levels.',
                      style: TextStyle(color: Colors.white, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
