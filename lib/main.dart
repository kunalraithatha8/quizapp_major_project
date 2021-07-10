import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:quizapp_major_project/about.dart';
import 'package:quizapp_major_project/ui/pages/home.dart';
import 'package:quizapp_major_project/ui/pages/login_screen.dart';
import 'package:quizapp_major_project/ui/pages/signup_screen.dart';

import 'models/authentication.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: MyApp(),
));

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trivial Method',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.green,
          fontFamily: "Montserrat",
          buttonColor: Colors.,
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              textTheme: ButtonTextTheme.primary
          )
      ),
      home: HomePage(),
    );
  }
}

class Welcome extends StatelessWidget {

  showAlertDialog(BuildContext context) {
 
    Widget okButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => MyApp()
        ));
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );

    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        
        Navigator.of(context, rootNavigator: true).pop('dialog');


      },
    );

  
    AlertDialog alert = AlertDialog(
     
      content: Text("Surely you want to signout?"),
      actions: [
        okButton, cancelButton
      ],
    );

  
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      return showDialog(context: context, builder: (context) => AlertDialog(
        title: Text("Surely you want to exit?"),
        actions: [
          FlatButton(onPressed: ()=> Navigator.pop(context, false), child: Text("No")),
          FlatButton(onPressed: ()=> Fluttertoast.showToast(msg: "Signout to exit").whenComplete(() => Navigator.pop(context)), child: Text("Yes"),),
        ],
      )
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.amber,
              title: Text('Quiz Page'),
              elevation: 0,
              actions: <Widget>[
                FlatButton(
                  child: Row(
                    children: <Widget>[
                      Text('Signout '),
                      Icon(Icons.logout)
                    ],
                  ),
                  textColor: Colors.white,
                  onPressed: (){
                    showAlertDialog(context);
                  },
                )
              ],
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    color: Colors.purple,
                    height: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200
                          child: DrawerHeader(
                            decoration: BoxDecoration(color: Colors.purple),
                            child: Text("Hello User", style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.menu),
                          SizedBox(
                            width: 240,
                            child: InkWell(
                              onTap: () {
                                
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => About()
                                ));
                              },
                              child: new Padding(
                                padding: new EdgeInsets.all(10.0),
                                child: new Text("User Account"),
                              ),
                            ),
                          ),
                        ],
                      ),

                    ],
                  )

                ],
              ),
            ),
            body: Center(
              child: Column(
                children: [
                  SizedBox(height: 100,),
                  Image.asset('assets/startquiz.png', height: 250, width: 250,),
                  SizedBox(height: 20,),
                  RaisedButton(
                    color: Colors.redAccent,
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => MyApp2()
                      ));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Text(
                      "Begin Quiz ->",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Authentication(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Signin App',
        theme: ThemeData(
          primaryColor: Colors.purple,
        ),
        home: OptionScreen(),
        routes: {
          SignupScreen.routeName: (ctx)=> SignupScreen(),
          LoginScreen.routeName: (ctx)=> LoginScreen(),

        },
      ),
    );
  }
}

class LogScrn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Authentication(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Signin App',
        theme: ThemeData(
          primaryColor: Colors.purple,
        ),
        home: LoginScreen(),
        routes: {
          SignupScreen.routeName: (ctx)=> SignupScreen(),
          LoginScreen.routeName: (ctx)=> LoginScreen(),

        },
      ),
    );
  }
}

class SignScrn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Authentication(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Signin App',
        theme: ThemeData(
          primaryColor: Colors.purple,
        ),
        home: SignupScreen(),
        routes: {
          SignupScreen.routeName: (ctx)=> SignupScreen(),
          LoginScreen.routeName: (ctx)=> LoginScreen(),
        },
      ),
    );
  }
}

class OptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.amber,
                  Colors.green,
                ]
            )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: new Image.asset('assets/quizlogo.png'),
              ),
              SizedBox(height: 45),
              SizedBox(
                width: 190,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => LogScrn()
                    ));
                  },
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("Signin"),
                ),

              ),
              SizedBox(height: 10),
              SizedBox(
                width: 190,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => SignScrn()
                    ));
                  },
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("User Registration"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}

