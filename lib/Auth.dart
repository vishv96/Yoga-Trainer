
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Stream<FirebaseUser> get onLoginSucsses => _userController.stream;

  Future authenticateWithGoogle() async{
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) async {
      if (_googleSignIn.currentUser != null) {
        final FirebaseAuth _auth = FirebaseAuth.fromApp(app);
        final GoogleSignInAuthentication googleAuth = await account.authentication;
        AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
        final FirebaseUser _user = await _auth.signInWithCredential(credential);
        checkAndAddUser(_user);
      }
    });
    await _googleSignIn.signIn();
  }


  Future authenticateWithEmailID(String _email,String _password) async{
      final FirebaseAuth _auth = FirebaseAuth.fromApp(app);
      final FirebaseUser user = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
      checkAndAddUser(user);
  }
  

  Future checkAndAddUser(FirebaseUser user) async {

    QuerySnapshot snap =  await Firestore.instance
        .collection('users')
        .where("userid", isEqualTo: user.uid).getDocuments();

    if(snap.documents.length > 0){
      _userController.add(user);
    }else{
      enterUserInfoToDB(user);
      _userController.add(user);
    }
    
  }

  void enterUserInfoToDB(FirebaseUser cUser){
    Firestore.instance.collection("users").document().setData({'userid': cUser.uid, 'issubscribed': false });
  }
  
}