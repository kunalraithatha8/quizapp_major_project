import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quizapp_major_project/main.dart';
import 'package:quizapp_major_project/models/category.dart';
import 'package:quizapp_major_project/ui/widgets/quiz_options.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomePage extends StatelessWidget {


  final List<Color> tileColors = [
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Colors.indigo,
    Colors.lightBlue,
    Colors.amber,
    Colors.deepOrange,
    Colors.red,
    Colors.brown
  ];


  @override
  Widget build(BuildContext context) {

    Future<bool> _onBackPressed() {
      return showDialog(context: context, builder: (context) => AlertDialog(
        title: Text("Do you really want to go back to the Hello Page?"),
        actions: [
          FlatButton(onPressed: ()=> Navigator.pop(context, false), child: Text("NO")),
          FlatButton(onPressed: ()=> Fluttertoast.showToast(msg: "Click On Goto Welcome Page").whenComplete(() => Navigator.pop(context)), child: Text("YES"),),
        ],
      )
      );
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Options'),
            elevation: 0,
            actions: <Widget>[
              FlatButton(
                child: Row(
                  children: <Widget>[
                    Text('Goto Welcome Page'),
                    Icon(Icons.logout)
                  ],
                ),
                textColor: Colors.white,
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => Welcome()
                  ));
                },
              )
            ],
          ),
          body: Stack(
            children: <Widget>[
              ClipPath(
                clipper: WaveClipperOne(),
                child: Container(
                  decoration:
                  BoxDecoration(color: Theme.of(context).primaryColor),
                  height: 200,
                ),
              ),
              CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        "Select a category to start the quiz",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: MediaQuery.of(context).size.width >
                                1000
                                ? 7
                                : MediaQuery.of(context).size.width > 600 ? 5 : 3,
                            childAspectRatio: 1.2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0),
                        delegate: SliverChildBuilderDelegate(
                          _buildCategoryItem,
                          childCount: categories.length,
                        )),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Widget _buildCategoryItem(BuildContext context, int index) {
    Category category = categories[index];
    return MaterialButton(
      elevation: 1.0,
      highlightElevation: 1.0,
      onPressed: () => _categoryPressed(context, category),
      shape: CircleBorder(
          side: BorderSide(
              width: 5,
              color: Colors.red
          )
      ),
      color: Colors.red,
      textColor: Colors.white70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (category.icon != null) Icon(category.icon),
          if (category.icon != null) SizedBox(height: 5.0),
          AutoSizeText(
            category.name,
            minFontSize: 10.0,
            textAlign: TextAlign.center,
            maxLines: 2,
            wrapWords: false,
          ),
        ],
      ),
    );
  }

  _categoryPressed(BuildContext context, Category category) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => BottomSheet(
        builder: (_) => QuizOptionsDialog(
          category: category,
        ),
        onClosing: () {},
      ),
    );
  }
}
