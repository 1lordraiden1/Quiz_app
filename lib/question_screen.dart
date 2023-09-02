import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:quiz_app/result.dart';

import 'answer_button.dart';

import 'package:quiz_app/data/questions.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  var currentQindex = 0;

  answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    setState(() {
      currentQindex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentQuestion = questions[currentQindex];

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(currentQuestion.text,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 235, 160, 248),
                fontSize: 23,
                fontWeight: FontWeight.bold,
              )),
          ...currentQuestion.getShuffledAnswers().map((answers) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: AnswerButton(
                onTap: () {
                  answerQuestion(answers);
                },
                text: answers,
              ),
            );
          }),
        ],
      ),
    );
  }
}



/*
if (questions.length  > currentQindex+1) {
        currentQindex++;
        
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Result(),
          ),
        );
      }
*/