import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'Login.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LandingView extends StatefulWidget{

  LandingView({Key key,this.app}) :super(key:key);
  final FirebaseApp app;
  String title;
  
  @override
  _LandingView createState() => _LandingView();
  
}


class _LandingView extends State<LandingView>{

  GoogleSignInAccount _currentUser;
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

//  Future<FirebaseUser> googleSignin(BuildContext context) async{
//    try{
//      GoogleSignInAccount signInAccount = await GoogleSignInAccount.in
//    }catch(error){
//
//    }
//  }

  Future<void> _handleSignIn() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.fromApp(widget.app);
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication gsa = await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.getCredential(idToken: null, accessToken: null)

      print("user name: ${user.displayName}");
      return user;
//      _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
//        if (_currentUser != null) {
//          print(account);
////          final FirebaseAuth _auth = FirebaseAuth.fromApp(widget.app);
////          _auth.signInWithCustomToken(account.t)
//        }
//      });
//      await _googleSignIn.signIn();

    } catch (error) {
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