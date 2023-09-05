import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({required this.onTap,required this.text, super.key});

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 51, 0, 80),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 40 ,vertical: 10),
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        
      ),
      onPressed: onTap,
      child: Text(text),
    );
  }
}
