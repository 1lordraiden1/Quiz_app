import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/question_summary.dart';

class Result extends StatelessWidget {
  Result(
      {super.key,
      required this.choosenAnswers,
      required this.correctAnswersCounter,
      required this.restart});
  List<String> choosenAnswers;

  int correctAnswersCounter;

  void Function() restart;

  List<Map<String, Object>> SummaryAnswers() {
    final List<Map<String, Object>> summary = [];
    for (int i = 0; i < choosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': choosenAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40.0),
        child: Column(
          
          children: [
            Text(
              "You answered $correctAnswersCounter out of ${choosenAnswers.length} questions correctly!",
              style: const TextStyle(
                color: Color.fromARGB(255, 131, 66, 243),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionSummary(SummaryAnswers()),
            const SizedBox(
              height: 30,
            ),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                restart();
              },
              icon: const Icon(
                Icons.restart_alt,
              ),
              label: const Text("Restart Quiz!"),
            )
          ],
        ),
      ),
    );
  }
}
