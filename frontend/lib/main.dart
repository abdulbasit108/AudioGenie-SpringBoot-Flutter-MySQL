import 'package:audio_genie/utils/constants.dart';
import 'package:audio_genie/screens/landing_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Set the default font family
        fontFamily: kPrimaryFont,
      ),
      home: const LandingScreen()
    );
  }
}
