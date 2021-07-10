import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'signup_screen.dart';

import 'package:quizapp_major_project/models/authentication.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'email ID' : '',
    'password': ''
  };

  void _showErrorDialog(String msg)
  {
    showDialog(
        context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Unexpected Error Occured'),
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
      await Provider.of<Authentication>(context, listen: false).logIn(
          _authData['email'],
          _authData['password']
      );
     // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => Welcome()
      ));



    } catch (error)
    {
      var errorMessage = 'Authentication is Unauthorized. Please retry after some time.';
      _showErrorDialog(errorMessage);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[
                Text('Signup'),
                Icon(Icons.person_add)
              ],
            ),
            textColor: Colors.white,
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
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
                  Colors.deepOrange,
                  Colors.amber,
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
                child:Image.asset('assets/sig.png'),
              ),
              Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    height: 270,
                    width: 310,
                    padding: EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            //email
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Email'),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value)
                              {
                                if(value.isEmpty || !value.contains('@'))
                                  {
                                    return 'invalid email ID';
                                  }
                                return null;
                              },
                              onSaved: (value)
                              {
                                _authData['email'] = value;
                              },
                            ),

                            //password
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Password'),
                              obscureText: true,
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
                            SizedBox(
                              height: 30,
                            ),
                            RaisedButton(
                              child: Text(
                                'Login'
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
