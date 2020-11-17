import 'package:flutter/material.dart';
import 'package:galerry_trying/screens/homeScreen.dart';

void main() => runApp(HeroApp());

class HeroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gallery task',
      home: MainScreen(),
    );
  }
}
