import 'package:flutter/material.dart';

class QuestionSummary extends StatelessWidget {
  const QuestionSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    ((data['question_index'] as int) + 1).toString(),
                    maxLines: 2,
                  ),
                  Expanded(
                    child: Column(
                      
                      children: [
                        Text(
                          (data['question']).toString(),
                          maxLines: 2,
                          
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
          
                          ),
                        ),
                        const SizedBox(),
                        Text(
                          (data['correct_answer']).toString(),
                        ),
                        Text(
                          (data['user_answer']).toString(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
