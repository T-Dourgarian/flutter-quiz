import "package:flutter/material.dart";
import "./landing_page.dart";

class ScorePage extends StatelessWidget {

  final int score;
  final int totalQuestions;

  ScorePage(this.score,this.totalQuestions);

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.greenAccent,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text("Your Score is ", style: new TextStyle(color:Colors.white, fontSize:30,fontWeight:FontWeight.bold)),
          new Text(score.toString() + "/" + totalQuestions.toString() ,style: new TextStyle(color:Colors.white, fontSize:30,fontWeight:FontWeight.bold)),
          new IconButton(
            icon: new Icon(Icons.arrow_right),
            color: Colors.white,
            iconSize: 50,
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new LandingPage()), (Route route) => route == null)
          )
        ],
      ),
    );
  }
}