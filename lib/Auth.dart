
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

class Auth{

  Auth.App(this.app);
  final FirebaseApp app;
  FirebaseUser user;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  StreamController<FirebaseUser> _userController =
  StreamController<FirebaseUser>.broadcast();

  Stream<FirebaseUser> get onGoogleLogin => _userController.stream;

  Future authenticateWithGoogle() async{
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) async {
      if (_googleSignIn.currentUser != null) {
        final FirebaseAuth _auth = FirebaseAuth.fromApp(app);
        final GoogleSignInAuthentication googleAuth = await account.authentication;
        AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
        final FirebaseUser _user = await _auth.signInWithCredential(credential);
        _userController.add(_user);
      }
    });
    await _googleSignIn.signIn();
  }
}