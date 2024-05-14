import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String _selectedAnswer = '';
  late AudioPlayer _audioPlayer;
  late String _currentQuestionSound;

  final List<Map<String, dynamic>> _quizData = [
    {
      'question': 'Hvaða tónbil er þetta?',
      'options': ['hrein fimmund', 'hrein ferund', 'lítil tvíund', 'stór tvíund'],
      'correctAnswer': 'hrein ferund',
      'sound': 'assets/audio/test_sound.mp3',
    },
    { 'question': 'Hvaða tónbil er þetta?',
      'options': ['hrein fimmund', 'hrein ferund', 'lítil tvíund', 'stór tvíund'],
      'correctAnswer': 'hrein fimmund',
      'sound': 'assets/audio/test_sound.mp3',
      },
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
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 8, 63, 108), // Add your desired background color here
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Text(
          'lærðu tónbil',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)), // Customize text color if needed
        ),
      ),
      titleSpacing: 400,
        
        
        
     ),
    body: DecoratedBox(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 8, 63, 108), // Add your desired background color here
      ),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assetts/images/pngegg.png'), 
            alignment: Alignment.center,
            fit: BoxFit.contain,
            
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _playQuestionSound(_quizData[0]['sound']);
                  _showQuestion(_quizData[0]);
                },
                child: const Text('Show Question'),
              ),
              if (_selectedAnswer.isNotEmpty) Text('Selected Answer: $_selectedAnswer'),
            ],
          ),
        ),
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
              ...((questionData['options'] as List<String>).map((option) {
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedAnswer = option;
                      _playQuestionSound(_currentQuestionSound);
                      Navigator.of(context).pop();
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