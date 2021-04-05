import 'package:flutter/material.dart';
import 'package:quiz_app/questions.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Quiz"),
          centerTitle: true,
        ),
        body: Quiz(),
      ),
    ),
  );
}

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final tickIcon = Icon(
    Icons.check,
    color: Colors.green,
  );

  final crossIcon = Icon(
    Icons.clear,
    color: Colors.red,
  );

  int index = 0;
  int score = 0;
  List<Icon> icons = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "Which city was this band formed in?",
          style: Theme.of(context).textTheme.headline6,
        ),
        Text(
          questions[index].band,
          style: Theme.of(context).textTheme.headline6,
        ),
        Image.network(
          questions[index].imageUrl,
          width: 300,
          height: 200,
          fit: BoxFit.cover,
        ),
        for (var answer in questions[index].answers)
          Container(
            width: 200,
            child: ElevatedButton(
              onPressed: () => _checkAnswer(answer),
              child: Text(answer),
            ),
          ),
        Row(
          children: icons,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ],
    );
  }

  _checkAnswer(selectedAnswer) {
    if (selectedAnswer == questions[index].correctAnswer) {
      setState(() {
        icons.add(tickIcon);
        score++;
        if (index < questions.length - 1) {
          index++;
        } else {
          _alertDialog();
        }
      });
    } else {
      setState(() {
        icons.add(crossIcon);

        if (index < questions.length - 1) {
          index++;
        } else {
          _alertDialog();
        }
      });
    }
  }

  _alertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Your result:"),
          content: Text("$score"),
        );
      },
    );
  }
}
