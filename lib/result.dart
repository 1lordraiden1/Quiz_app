import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';

class Result extends StatelessWidget {
  Result({super.key, required this.choosenAnswers});
  List<String> choosenAnswers;

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
            const Text("You answered X out of Y questions correctly!"),
            const SizedBox(
              height: 30,
            ),
            ListTile(),
            TextButton(
              onPressed: () {},
              child: const Text('Try Again ?'),
            ),
          ],
        ),
      ),
    );
  }
}
