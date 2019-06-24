import 'package:flutter/material.dart';
import 'Register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';



class Login extends StatefulWidget{
  Login( {this.app}) : super();
  final FirebaseApp app;
  String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login>{
  GlobalKey<FormState> formKey =  GlobalKey<FormState>();
  String _email,_password;
  // "_auth" is for authentication


  Future<void> onLogin(BuildContext  context) async{
    if (formKey.currentState.validate()){
      formKey.currentState.save();
      try{
        final FirebaseAuth _auth = FirebaseAuth.fromApp(widget.app);
        List<String> methodes = await _auth.fetchSignInMethodsForEmail(email: _email);
        print(methodes);
        final FirebaseUser user = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
      }catch (error){
        print(error);
        Toast.show(error.message, context, duration: 10, gravity: Toast.TOP);
      }
    }
  }


  onRegister(BuildContext  context){
    Navigator.push(context,MaterialPageRoute(builder: (context) => Register(widget.app)));
  }


  @override
  Widget build(BuildContext  context){
    return Scaffold(

      appBar: AppBar(
        title: Text("Login with email"),
      ),

      body: Center(

        child: Padding(
          padding: EdgeInsets.all(20),
          child:Form(
            key: formKey,
            child:  Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter your Email",
                      labelText: "Username",
                    ),
                    validator: (input){
                      if (input.isEmpty){
                        return "Please enter your email";
                      }
                    },
                    onSaved: (input){
                      _email = input;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter your password",
                      labelText: "Password",
                    ),
                    validator: (input){
                      if (input.isEmpty){
                        return "Please enter your Password";
                      }
                    },
                    onSaved: (input){
                      _password = input;
                    },
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children:<Widget>[
                        FlatButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          splashColor: Colors.blueAccent,
                          onPressed: () {
                            onLogin(context);
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                        FlatButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          splashColor: Colors.blueAccent,
                          onPressed: () {
                            onRegister(context);
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ]
                  ),
                ]
            ),
          )

        ),
      ),
    );
  }

}