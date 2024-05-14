import 'package:flutter/material.dart';
import 'package:lokaverkefni/questions/quiz_screen.dart';
import 'package:lokaverkefni/quiz.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const QuizScreen(),
    );
  }
}

