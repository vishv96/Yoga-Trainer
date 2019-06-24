import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';


class Register extends StatefulWidget{
  Register(this.app): super();
  final FirebaseApp app;
  @override
  _RegisterView createState() => _RegisterView();
}


class _RegisterView extends State<Register>{

  String _email, _username, _password;
  GlobalKey<FormState> formKey =  GlobalKey<FormState>();

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  Future<void> startRegister() async {

    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    final FirebaseAuth _auth = FirebaseAuth.fromApp(widget.app);

    DatabaseReference _refrence = database.reference().child("users");

     final formState = formKey.currentState;
     if (formState.validate()){
        formState.save();
        try{
          final FirebaseUser user = await _auth.createUserWithEmailAndPassword(
            email: _email,
            password: _password,
          );
        }catch(e){
          showToast(e.toString());
        }

     }else{
       //TODO: Error handling
     }
  }
  
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Register"),
      ),
      
      body: Center(
        heightFactor: 1.2,
        child: Padding(
            padding: EdgeInsets.all(20),
            child:Form(
              key: formKey,
              child: Wrap(
                children: <Widget>[
                  TextFormField(
                    validator: (input){
                      if (input.isEmpty){
                        return "Please enter the email";
                      }
                    },
                    onSaved: (input){
                      _email = input;
                    },
                    decoration: const InputDecoration(
                      hintText: "",
                      labelText: "Email",
                    ),
                  ),
                  TextFormField(
                    validator: (input){
                      if (input.isEmpty){
                        return "Please enter the username";
                      }
                    },
                    onSaved: (input){
                      _username = input;
                    },
                    decoration: const InputDecoration(
                      hintText: "",
                      labelText: "Username",
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (input){
                      if (input.isEmpty){
                        return "Please enter the password";
                      }
                    },
                    onSaved: (input){
                      _password = input;
                    },
                    decoration: const InputDecoration(
                      hintText: "",
                      labelText: "Password",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        FlatButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          splashColor: Colors.blueAccent,
                          onPressed: () {
                            startRegister();
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ) ,
        ),
      ),
      
    );
  }
}