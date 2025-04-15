# Color Mixer Game

A Flutter-based Color Mixer Game that challenges you to mix colors to match target colors across three difficulty levels.

## Features

- Mix colors by tapping colored circles
- Remove colors with minus buttons
- Match percentage calculation with real-time feedback
- Three difficulty levels (Easy, Medium, Hard)
- Solution feature to see the correct color recipe
- Reset and Next buttons for convenient gameplay
- Responsive design for various screen sizes

## Implementation Details

This game is implemented using Flutter and follows a clean architecture:

- **Models**: Manages game state and logic
- **Constants**: Defines colors and difficulty settings
- **Screens**: Displays the user interface
- **Widgets**: Modular UI components
- **Utils**: Helper functions for color calculations

## Running the Game

1. Make sure you have Flutter installed
2. Clone this repository
3. Run `flutter pub get` to install dependencies
4. Connect a device or emulator
5. Run `flutter run` to start the game

## How to Play

- Tap colored circles to add that color to your mix
- Use minus buttons to remove colors
- Try to match the target color as closely as possible
- A 99% or better match is considered a success
- Use the "Solution" button if you're stuck
- Press "Next" to get a new target color
- Press "Reset" to clear your current mix
- Change difficulty using the dropdown in the app bar

## Difficulty Levels

- **Easy**: 2-3 colors with weights 1-3, shows 4 base colors
- **Medium**: 2-4 colors with weights 1-5, shows 5 base colors
- **Hard**: 3-5 colors with weights 1-7, shows all 6 base colors

Enjoy the game!# app
