import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:audioplayers/audio_cache.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('QUIZZLER'),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  final player = AudioCache();
  int rightQuestions = 0;

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();
    int totalQuestions = quizBrain.numberOfQuestions();
    bool questionsFinished = quizBrain.isFinished();

    setState(() {
      if (userPickedAnswer == correctAnswer) {
        rightQuestions++;
        player.play('correct.wav');
        Alert(
          context: context,
          title: "ACERTOU",
          style: AlertStyle(
              backgroundColor: Colors.green,
              titleStyle: TextStyle(color: Colors.white)),
          content: Icon(
            Icons.check,
            color: Colors.white,
            size: 50.0,
          ),
          buttons: [],
        ).show();
        scoreKeeper.add(
          Icon(Icons.check, color: Colors.green),
        );
      } else {
        player.play('wrong.wav');
        Alert(
          context: context,
          title: "ERROU",
          style: AlertStyle(
              backgroundColor: Colors.red,
              titleStyle: TextStyle(color: Colors.white)),
          content: Icon(
            Icons.close,
            color: Colors.white,
            size: 50.0,
          ),
          buttons: [],
        ).show();
        scoreKeeper.add(
          Icon(Icons.close, color: Colors.red),
        );
      }

      quizBrain.nextQuestion();

      if (questionsFinished == true) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "QUIZ CONCLUÍDO",
          desc: "$rightQuestions/$totalQuestions",
          buttons: [
            DialogButton(
              child: Text(
                "REINICIAR",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
        quizBrain.reset();
        scoreKeeper.clear();
        rightQuestions = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'Verdadeiro',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'Falso',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: scoreKeeper,
          ),
        ),
      ],
    );
  }
}
