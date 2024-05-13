import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late String _selectedAnswer;

  // Define quiz questions and correct answers
  List<Map<String, dynamic>> _quizData = [
    {
      'question': 'Hvaða tónbil er þetta?',
      'options': ['hrein fimmund', 'hrein ferund', 'lítil tvíund', 'stór tvíund'],
      'correctAnswer': 'hrein ferund',
    },
    // Add more questions here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('lærðu tónbil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _quizData[0]['question'], // Display the current question
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            // Display answer options as buttons
            ...(_quizData[0]['options'] as List<String>).map((option) {
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedAnswer = option;
                    _checkAnswer(option); // Check if the selected answer is correct
                  });
                },
                child: Text(option),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _checkAnswer(String selectedOption) {
    String correctAnswer = _quizData[0]['correctAnswer'];
    if (selectedOption == correctAnswer) {
      // Display a message indicating that the answer is correct
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Correct Answer!'),
            content: Text('Congratulations! You chose the correct answer.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Display a message indicating that the answer is incorrect
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Incorrect Answer!'),
            content: Text('Sorry, the correct answer is: $correctAnswer.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
