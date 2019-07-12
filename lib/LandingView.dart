import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'Login.dart';
import 'Auth.dart';
import 'Home.dart';


class LandingView extends StatefulWidget{

  LandingView({Key key,this.app}) :super(key:key);
  final FirebaseApp app;
  String title;
  
  @override
  _LandingView createState() => _LandingView();
  
}


class _LandingView extends State<LandingView>{

  FirebaseUser user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



  }

  void loginUsingEmail(BuildContext context){
    Navigator.push(context,MaterialPageRoute(builder: (context) => Login(app:widget.app)));
  }

  void navigateToHome(BuildContext context,FirebaseUser currentUser){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: currentUser,app: widget.app,)));
  }

  Future<void> _handleSignIn(BuildContext context) async {
    
    try {
      Auth auth = Auth.App(widget.app);
      await auth.authenticateWithGoogle();
      auth.onLoginSucsses.listen((FirebaseUser user){
          navigateToHome(context, user);
      });
    }catch (error){
      print(error);
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              SignInButton(
                Buttons.Google,
                text: "Sign in with Google",
                onPressed: () {
                  _handleSignIn(context);
                },
              ),
              FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                splashColor: Colors.blueAccent,
                onPressed: () {
                  loginUsingEmail(context);
                },
                child: Text(
                  "Login using email",
                  style: TextStyle(fontSize: 14.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
}