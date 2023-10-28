import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/models/quiz_question.dart';
import 'package:quiz_app/models/sql_helper.dart';
import 'package:quiz_app/question_screen.dart';
import 'package:quiz_app/result.dart';
import 'package:quiz_app/start.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  Widget? activeScreen;

  List<String> selectedAnswers = [];

  int correctAnswersCounter = 0;

  @override
  void initState() {
    activeScreen = StartScreen(startQ: switchScreen);
    _refreshQuestions();

    super.initState();
  }

  void _refreshQuestions() async {
    final data = await SQLHelper.getItems();
    questions = [];
    setState(() {
      for (int i = 0; i < data.length; i++) {
        questions.add(
          QuizQuestion(
            data[i]['title'],
            [
              data[i]['ans1'],
              data[i]['ans2'],
              data[i]['ans3'],
              data[i]['ans4'],
            ],
          ),
        );
      }
    });
  }

  void switchScreen() {
    setState(() {
      _refreshQuestions();
      activeScreen = QuestionScreen(
        onSelectAnswer: chooseAnswer,
      );
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    for (int i = 0; i < selectedAnswers.length; i++) {
      if (questions[i].answers[0] == answer) {
        correctAnswersCounter++;
      }
    }

    void restartQuiz() {
      selectedAnswers = [];
      correctAnswersCounter = 0;
      setState(() {
        activeScreen = StartScreen(
          startQ: switchScreen,
        );
      });
    }

    if (selectedAnswers.length == questions.length) {
      setState(() {
        //selectedAnswers = [];
        activeScreen = Result(
          choosenAnswers: selectedAnswers,
          correctAnswersCounter: correctAnswersCounter,
          restart: restartQuiz,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz app',
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 51, 0, 80),
                Color.fromARGB(255, 63, 8, 158),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}
