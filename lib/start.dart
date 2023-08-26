import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class StartScreen extends StatelessWidget {
  const StartScreen({this.startQ,super.key});

  final void Function()? startQ;
  @override
  Widget build(BuildContext context) {
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
        Text(
          "Welcome to Quiz app",
          style: GoogleFonts.lato(
            color: const Color.fromARGB(255, 235, 160, 248),
            fontSize: 20,
          )
        ),
        const SizedBox(
          height: 40,
        ),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
          ),
          onPressed:startQ,
          icon: const Icon(
            Icons.start,
          ),
          label: const Text("Start here"),
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