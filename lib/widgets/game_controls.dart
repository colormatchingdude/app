import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/color_game.dart';
import '../constants/game_constants.dart';

class GameControls extends StatelessWidget {
  const GameControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorGameModel = Provider.of<ColorGameModel>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 480;
    
    // Determine orientation based on screen size
    final controlsLayout = isSmallScreen
        ? Axis.vertical  // Column for small screens
        : Axis.horizontal; // Row for larger screens
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0x33EEEEEE),
            width: 1,
          ),
        ),
      ),
      child: Flex(
        direction: controlsLayout,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Reset Button
          ElevatedButton(
            onPressed: () => colorGameModel.resetGame(),
            style: ElevatedButton.styleFrom(
              backgroundColor: kResetButtonColor,
              minimumSize: const Size(100, 45),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
            ),
            child: const Text(
              'Reset',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          // Add spacing between buttons
          SizedBox(
            width: controlsLayout == Axis.horizontal ? 15 : 0,
            height: controlsLayout == Axis.vertical ? 10 : 0,
          ),
          
          // Solution Button
          ElevatedButton(
            onPressed: () => colorGameModel.showSolution(),
            style: ElevatedButton.styleFrom(
              backgroundColor: kSolutionButtonColor,
              minimumSize: const Size(100, 45),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
            ),
            child: const Text(
              'Solution',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          // Add spacing between buttons
          SizedBox(
            width: controlsLayout == Axis.horizontal ? 15 : 0,
            height: controlsLayout == Axis.vertical ? 10 : 0,
          ),
          
          // Next Button
          ElevatedButton(
            onPressed: () => colorGameModel.nextTargetColor(),
            style: ElevatedButton.styleFrom(
              backgroundColor: kNextButtonColor,
              minimumSize: const Size(100, 45),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
            ),
            child: const Text(
              'Next',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          // Add spacing between buttons
          SizedBox(
            width: controlsLayout == Axis.horizontal ? 15 : 0,
            height: controlsLayout == Axis.vertical ? 10 : 0,
          ),
          
          // Buy Me A Coffee Button
          InkWell(
            onTap: () => _launchBuyMeACoffee(),
            child: Container(
              height: 45,
              constraints: const BoxConstraints(maxWidth: 180),
              child: Image.network(
                'https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Launch Buy Me A Coffee URL
  void _launchBuyMeACoffee() async {
    const url = 'https://buymeacoffee.com/colormatchingdude';
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Could not launch $url: $e');
    }
  }
}
