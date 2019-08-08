import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import "../utils/question.dart";
import "../utils/quiz.dart";
import "../UI/answer_button.dart";
import "../UI/question_text.dart";
import "../UI/correct_wrong_overlay.dart";
import "./score_page.dart";


class QuizPage extends StatefulWidget {
  @override 
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("Elon Musk is human",false),
    new Question("Pizza is Healthy",false),
    new Question("Flutter is Awesome",true)
  ]);

  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayVisible = false;

  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState(() {
      overlayVisible = true;
    });
  }


  @override  
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          children: <Widget>[ // this is main page
            new AnswerButton(true,() => handleAnswer(true)),
            new QuestionText(questionText,questionNumber),
            new AnswerButton(false,() => handleAnswer(false)),
          ],
        ),
        overlayVisible == true ? new CorrectWrongOverlay(
          isCorrect,
          () {
            currentQuestion = quiz.nextQuestion;
            this.setState(() {
              if (quiz.length == questionNumber) {
                Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new ScorePage(quiz.score,quiz.length)),(Route route) => route == null);
                return;
              }
              overlayVisible = false;
              questionText = currentQuestion.question;
              questionNumber = quiz.questionNumber;
            });
          },
        ) : new Container() 
      ],
    );
  }
}
