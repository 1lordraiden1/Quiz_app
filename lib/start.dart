import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/home.dart';

import 'data/questions.dart';
import 'models/quiz_question.dart';
import 'models/sql_helper.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({this.startQ, super.key});

  final void Function()? startQ;
  @override
  Widget build(BuildContext context) {
    void _refreshQuestions() async {
      final data = await SQLHelper.getItems();

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
    }

    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/quiz-logo.png',
          width: 280,
        ),
        const SizedBox(
          height: 80,
        ),
        Text("Welcome to Quiz app",
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 235, 160, 248),
              fontSize: 20,
            )),
        const SizedBox(
          height: 40,
        ),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
          ),
          onPressed: startQ,
          icon: const Icon(
            Icons.start,
          ),
          label: const Text("Start here"),
        ),
        const SizedBox(
          height: 10,
        ),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          icon: const Icon(
            Icons.add,
          ),
          label: const Text("Admin Site"),
        )
      ],
    ));
  }
}


//OutlinedButton -> child -> text

//OutlinedButton.icon -> label -> text 

/*Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Quiz(),
              ),
            );
*/