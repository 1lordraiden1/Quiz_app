import 'package:flutter/material.dart';

class QuestionSummary extends StatelessWidget {
  const QuestionSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      
      child: SingleChildScrollView(
        child: Column(
          
          children: summaryData.map((data) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: data['correct_answer'] == data['user_answer'] ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          ((data['question_index'] as int) + 1).toString(),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    
                    child: Column(
                      
                      children: [
                        Text(
                          (data['question']).toString(),
                          
                          textAlign: TextAlign.left,
                          
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            
          
                          ),
                        ),
                        const SizedBox(),
                        Text(
                          (data['correct_answer']).toString(),
                          style: const TextStyle(
                            color: Colors.cyan,
                          ),
                          textAlign: TextAlign.left,
                          
                        ),
                        Text(
                          (data['user_answer']).toString(),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 194, 89, 255),
                          ),
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
