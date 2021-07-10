import 'package:flutter/material.dart';
import 'package:quizapp_major_project/models/category.dart';
import 'package:quizapp_major_project/models/question.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:quizapp_major_project/ui/pages/quiz_finished.dart';
import 'package:html_unescape/html_unescape.dart';

import 'home.dart';

class QuizPage extends StatefulWidget {
  final List<Question> questions;
  final Category category;

  const QuizPage({Key key, @required this.questions, this.category})
      : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final TextStyle _questionStyle = TextStyle(
      fontSize: 19.0, fontWeight: FontWeight.w500, color: Colors.white);

  int _currentIndex = 0;
  final Map<int, dynamic> _answers = {};
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Question question = widget.questions[_currentIndex];
    final List<dynamic> options = question.incorrectAnswers;
    if (!options.contains(question.correctAnswer)) {
      options.add(question.correctAnswer);
      options.shuffle();
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text(widget.category.name),
          elevation: 0,
        ),
        body: Stack(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                height: 180,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white70,
                        child: Text("${_currentIndex + 1}"),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Text(
                          HtmlUnescape().convert(
                              widget.questions[_currentIndex].question),
                          softWrap: true,
                          style: MediaQuery.of(context).size.width > 600
                              ? _questionStyle.copyWith(fontSize: 25.0)
                              : _questionStyle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.0),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ...options.map((option) => RadioListTile(

                              title: Text(HtmlUnescape().convert("$option"),style: MediaQuery.of(context).size.width > 600
                              ? TextStyle(
                                fontSize: 25.0
                              ) : null,),
                              groupValue: _answers[_currentIndex],
                              value: option,
                              onChanged: (value) {
                                setState(() {
                                  _answers[_currentIndex] = option;
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: RaisedButton(
                        padding: MediaQuery.of(context).size.width > 600
                              ? const EdgeInsets.symmetric(vertical: 19.0,horizontal: 60.0) : null,
                        child: Text(
                            _currentIndex == (widget.questions.length - 1)
                                ? "Submit"
                                : "Next", style: MediaQuery.of(context).size.width > 600
                              ? TextStyle(fontSize: 25.0) : null,),
                        onPressed: _nextSubmit,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _nextSubmit() {
    if (_answers[_currentIndex] == null) {
      _key.currentState.showSnackBar(SnackBar(
        content: Text("You must select an answer to continue."),
      ));
      return;
    }
    if (_currentIndex < (widget.questions.length - 1)) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => QuizFinishedPage(
              questions: widget.questions, answers: _answers)));
    }
  }

  Future<bool> _onWillPop() async {
    return showDialog<bool>(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text(
                "Are you willing to quit the quiz? All your progress till now will be unsaved."),
            title: Text("Warning!"),
            actions: <Widget>[
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => HomePage()
                  ));
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ],
          );
        });
  }
}
