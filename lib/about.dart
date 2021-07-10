import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("About"),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue,
                  Colors.transparent,
                ]
            )
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 80,),
              Text("Quiz Application Is Created By: Kunal Raithatha"),
              SizedBox(height: 15),
              Text("This App Is Made Using:-"),
              SizedBox(height: 15),
              Column(
                children: [
                  Text("Flutter Toast"),
                  Text("Trivialmethods Database API"),
                  Text("WillPopScope Widget"),
                  Text("ClipperPath"),
                  Text("Stack"),
                  Text("AppBar"),
                  Text("TextFormField"),
                  Text("Asset Images"),
                  Text("Drawer"),
                  Text("Along with Several other widgets")
                ],
              ),
              SizedBox(height: 30,),
              Text("Bibliography and References:-"),
              SizedBox(height: 15),
              Text("flutter.dev"),
              Text("freetutorialsus"),
              Text("freecodecamp.org"),
              Text("Stack Overflow"),
            ],
          ),

        ),
      ),
    );
  }

}