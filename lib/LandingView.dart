import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'Login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LandingView extends StatefulWidget{

  LandingView({Key key,this.app}) :super(key:key);
  final FirebaseApp app;
  String title;
  
  @override
  _LandingView createState() => _LandingView();
  
}


class _LandingView extends State<LandingView>{

  FirebaseUser user;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  void loginUsingEmail(BuildContext context){
    Navigator.push(context,MaterialPageRoute(builder: (context) => Login(app:widget.app)));
  }

  Future<void> _handleSignIn() async {
    
    try {
      Auth auth = Auth.App(widget.app);
      await auth.authenticateWithGoogle();
      auth.onGoogleLogin.listen((FirebaseUser user){
        print(user.email);
        Firestore(app: widget.app).collection('levels').document('1').get().then((DocumentSnapshot ds) {
          // use ds as a snapshot
          print(ds);
        });
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
                  _handleSignIn();
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