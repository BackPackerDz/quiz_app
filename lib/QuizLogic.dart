import 'package:quiz_app/question.dart';

class QuizLogic {
  int _questionIndex = 0;

  List<Question> questions = [
    Question(
        flagName: 'dz.png',
        answer1: 'Algérie',
        answer2: 'France',
        answer3: 'Grèce',
        correctAnswer: 'Algérie'),
    Question(
        flagName: 'be.png',
        answer1: 'Autriche',
        answer2: 'Belgique',
        answer3: 'Bosnie-Herzégovine',
        correctAnswer: 'Belgique'),
    Question(
        flagName: 'fr.png',
        answer1: 'Bulgarie',
        answer2: 'Croatie',
        answer3: 'France',
        correctAnswer: 'France'),
    Question(
        flagName: 'gb.png',
        answer1: 'Royaume-Uni',
        answer2: 'Russie',
        answer3: 'Serbie',
        correctAnswer: 'Royaume-Uni'),
    Question(
        flagName: 'de.png',
        answer1: 'Royaume-Uni',
        answer2: 'Russie',
        answer3: 'Allemagne',
        correctAnswer: 'Allemagne'),
  ];

  String getFlagName() {
    return questions[_questionIndex].flagName;
  }

  String getAnswer1() {
    return questions[_questionIndex].answer1;
  }

  String getAnswer2() {
    return questions[_questionIndex].answer2;
  }

  String getAnswer3() {
    return questions[_questionIndex].answer3;
  }

  String getCorrectAnswer() {
    return questions[_questionIndex].correctAnswer;
  }

  bool isFinished() {
    if (_questionIndex >= questions.length - 1) return true;
    return false;
  }

  nextQuestion() {
    _questionIndex++;
  }
}
