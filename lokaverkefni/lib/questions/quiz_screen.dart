import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:lokaverkefni/main.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String _selectedAnswer = ''; // Initialize here instead of using 'late'
  late AudioPlayer _audioPlayer;
  late String _currentQuestionSound;

  // Define quiz data with questions, options, correct answers, and sound file paths
  final List<Map<String, dynamic>> _quizData = [
    {
      'question': 'Hvaða tónbil er þetta?',
      'options': ['hrein fimmund', 'hrein ferund', 'lítil tvíund', 'stór tvíund'],
      'correctAnswer': 'hrein ferund',
      'sound': 'assets/audio/test_sound.mp3', // Example sound file path
    },
    // Add more questions here
  ];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

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
            ElevatedButton(
              onPressed: () {
                _playQuestionSound(_quizData[0]['sound']);
                _showQuestion(_quizData[0]);
              },
              child: Text('Show Question'),
            ),
            // Display selected answer
            if (_selectedAnswer.isNotEmpty) Text('Selected Answer: $_selectedAnswer'),
          ],
        ),
      ),
    );
  }

  void _showQuestion(Map<String, dynamic> questionData) {
    setState(() {
      _currentQuestionSound = questionData['sound'];
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(questionData['question']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Display answer options as buttons
              ...((questionData['options'] as List<String>).map((option) {
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedAnswer = option;
                      Navigator.of(context).pop(); // Close the dialog
                    });
                  },
                  child: Text(option),
                );
              }).toList()),
            ],
          ),
        );
      },
    );
  }

  Future<void> _playQuestionSound(String soundPath) async {
    if (soundPath.isNotEmpty) {
      await _audioPlayer.play(soundPath, isLocal: true);
    }
  }
}
