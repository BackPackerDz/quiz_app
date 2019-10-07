import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'QuizLogic.dart';

class FlagsScreen extends StatefulWidget {
  @override
  _FlagsScreenState createState() => _FlagsScreenState();
}

class _FlagsScreenState extends State<FlagsScreen> {
  QuizLogic quizLogic = QuizLogic();
  List<Icon> scoresIcon = [];
  int numberOfGoodAnswer = 0;
  AudioCache player = AudioCache();
  Timer timer;
  int start = 5;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void playSound({bool isCorrect}) {
    String soundPath;

    if (isCorrect) {
      soundPath = '/sounds/correct.wav';
    } else {
      soundPath = '/sounds/incorrect.wav';
    }

    player.play(soundPath);
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (start < 1) {
          // Le compte à rebour est à zéro
          handleAnswer(null);
        } else {
          start--;
        }
      });
    });
  }

  updateScore({bool isGood}) {
    setState(() {
      scoresIcon = List.from(scoresIcon);
      if (isGood) {
        scoresIcon.add(Icon(
          Icons.check,
          color: Colors.green,
          size: 30,
        ));
      } else {
        scoresIcon.add(Icon(
          Icons.close,
          color: Colors.red,
          size: 30,
        ));
      }
    });
  }

  handleAnswer(String answerByUser) {
    // L'utilisateur a fait juste
    if (quizLogic.getCorrectAnswer() == answerByUser) {
      numberOfGoodAnswer++;
      updateScore(isGood: true);
      playSound(isCorrect: true);
    } else {
      // l'utilisateur a fait faux
      updateScore(isGood: false);
      playSound(isCorrect: false);
    }

    setState(() {
      start = 5;
    });

    // On vérifie si notre quiz est finis ou pas
    if (quizLogic.isFinished()) {
      print('Tu as finis le quiz bravo coco');

      timer.cancel();

      Alert(
        context: context,
        title: "Partie terminée",
        desc: "Tu as $numberOfGoodAnswer bonne(s) réponse(s)",
        buttons: [
          DialogButton(
            child: Text(
              "Quitter",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              // Pour quitter le pop-up
              Navigator.pop(context);
              // Pour quitter la partie
              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
    } else {
      setState(() {
        quizLogic.nextQuestion();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Text(
                '$start',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              height: 300,
              padding: EdgeInsets.only(bottom: 30.0),
              child: Image.asset('assets/flags/${quizLogic.getFlagName()}'),
            ),
            CustomButton(
              textButton: quizLogic.getAnswer1(),
              onPressed: () {
                print('Tu as cliqué sur le premier bouton');
                handleAnswer(quizLogic.getAnswer1());
              },
            ),
            CustomButton(
              textButton: quizLogic.getAnswer2(),
              onPressed: () {
                print('Tu as cliqué sur le deuxieme bouton');
                handleAnswer(quizLogic.getAnswer2());
              },
            ),
            CustomButton(
              textButton: quizLogic.getAnswer3(),
              onPressed: () {
                handleAnswer(quizLogic.getAnswer3());
              },
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 30,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: scoresIcon,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String textButton;
  final Function onPressed;

  CustomButton({this.textButton, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: EdgeInsets.only(
        left: 30.0,
        right: 30.0,
        bottom: 30.0,
      ),
      child: RaisedButton(
        onPressed: onPressed,
        child: Text(
          textButton,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
