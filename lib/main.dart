import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:color_mixer_game/screens/game_screen.dart';
import 'package:color_mixer_game/models/color_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ColorGame(),
      child: MaterialApp(
        title: 'ColorMix',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Roboto',
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF333333),
            elevation: 4,
          ),
          scaffoldBackgroundColor: const Color(0xFFF0F0F0),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Color(0xFF333333)),
            titleLarge: TextStyle(color: Color(0xFF555555)),
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFF007BFF),
            secondary: const Color(0xFF17A2B8),
            error: const Color(0xFFDC3545),
          ),
        ),
        home: const GameScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}