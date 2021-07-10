import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:quizapp_major_project/main.dart';
import 'package:quizapp_major_project/models/authentication.dart';

import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _passwordController = new TextEditingController();

  Map<String, String> _authData = {
    'email ID' : '',
    'password' : ''
  };

  void _showErrorDialog(String msg)
  {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occured'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: (){
                Navigator.of(ctx).pop();
              },
            )
          ],
        )
    );
  }

  Future<void> _submit() async
  {
    if(!_formKey.currentState.validate())
      {
        return;
      }
    _formKey.currentState.save();

    try{
      await Provider.of<Authentication>(context, listen: false).signUp(
          _authData['email ID'],
          _authData['password']
      );
      Fluttertoast.showToast(msg: "User Registered Login Page To Procced!");
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => LoginScreen()
      ));

    } catch(error)
    {
      var errorMessage = 'Authentication is Unauthorized. Please retry after some time.';
      _showErrorDialog(errorMessage);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),

        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[
                Text('Signin'),
                Icon(Icons.person)
              ],
            ),
            textColor: Colors.white,
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
          )
        ],
      ),

      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.amber,
                      Colors.green,
                    ]
                )
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 150,
                child:Image.asset('assets/regis.png'),
              ),
              Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    height: 290,
                    width: 300,
                    padding: EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            //email
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Email ID'),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value)
                              {
                                if(value.isEmpty || !value.contains('@') )
                                {
                                  return 'invalid email ID';
                                }
                                return null;
                              },
                              onSaved: (value)
                              {
                                _authData['email ID'] = value;
                              },
                            ),

                            //password
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Password'),
                              obscureText: true,
                              controller: _passwordController,
                              validator: (value)
                              {
                                if(value.isEmpty || value.length<=5)
                                {
                                  return 'invalid password';
                                }
                                return null;
                              },
                              onSaved: (value)
                              {
                                _authData['password'] = value;
                              },
                            ),

                            //Confirm Password
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Confirm Password'),
                              obscureText: true,
                              validator: (value)
                              {
                                if(value.isEmpty || value != _passwordController.text)
                                {
                                  return 'invalid password';
                                }
                                return null;
                              },
                              onSaved: (value)
                              {

                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            RaisedButton(
                              child: Text(
                                  'Register & Signin Now'
                              ),
                              onPressed: ()
                              {
                                _submit();
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              color: Colors.amber,
                              textColor: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
