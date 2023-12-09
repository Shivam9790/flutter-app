import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Question {
  String text;
  List<String> options;
  int correctAnswerIndex;
  String category;

  Question(this.text, this.options, this.correctAnswerIndex, this.category);
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questions = [
    Question("What is the capital of France?",
        ["Berlin", "Madrid", "Paris", "Rome"], 2, "general_knowledge"),
    Question(
        "Who is often referred to as the 'Father of Computers'?",
        ["Bill Gates", "Charles Babbage", "Steve Jobs", "Alan Turing"],
        1,
        "technology"),
    Question("Which sport does Cristiano Ronaldo play?",
        ["Basketball", "Soccer", "Tennis", "Golf"], 1, "sports"),
    Question("What is the largest planet in our solar system?",
        ["Earth", "Jupiter", "Mars", "Saturn"], 1, "general_knowledge"),
    Question(
        "Who developed the theory of psychoanalysis?",
        ["Sigmund Freud", "B.F. Skinner", "Ivan Pavlov", "John Watson"],
        0,
        "psychology"),
    // Add more questions for other topics
  ];

  int currentQuestionIndex = 0;
  int score = 0;

  void answerSelected(int selectedIndex) {
    if (selectedIndex == questions[currentQuestionIndex].correctAnswerIndex) {
      // Correct answer
      setState(() {
        score++;
      });
    }

    // Move to the next question or end the quiz
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        // End of the quiz
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Quiz Completed"),
              content: Text("Your score: $score out of ${questions.length}"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Reset quiz for future attempts
                    setState(() {
                      currentQuestionIndex = 0;
                      score = 0;
                    });
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Quiz App"),
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    questions[currentQuestionIndex].text,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Column(
                children: questions[currentQuestionIndex]
                    .options
                    .asMap()
                    .entries
                    .map((entry) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        answerSelected(entry.key);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        onPrimary: Colors.white,
                      ),
                      child: Text(entry.value),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: QuizScreen(),
    );
  }
}
