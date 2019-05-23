import 'package:flutter/material.dart';
import 'question_bank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(MyApp());

QuestionBank questionBank = QuestionBank();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> iconList = [];
  Icon icon;

  checkAnswer(selectedAnswer) {
    setState(() {
      if (selectedAnswer == questionBank.getAnswer()) {
        iconList.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        iconList.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
      if (!questionBank.nextQuestion()) {
        Alert(
          context: context,
          title: "Quiz Completed",
          desc: "Congratulations, you have completed.",
          buttons: [
            DialogButton(
              child: Text(
                "Restart",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              color: Color.fromRGBO(0, 179, 134, 1.0),
            )
          ],
        ).show();
        questionBank.resetQuiz();
        iconList = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBank.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(20.0),
            color: Colors.green,
            child: FlatButton(
              onPressed: () {
                checkAnswer(true);
              },
              child: Text(
                'True',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(20.0),
            color: Colors.red,
            child: FlatButton(
              onPressed: () {
                checkAnswer(false);
              },
              child: Text(
                'False',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: iconList,
          ),
        ),
      ],
    );
  }
}
