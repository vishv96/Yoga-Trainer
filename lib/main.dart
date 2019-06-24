import 'dart:io';
import 'LandingView.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'package:firebase_core/firebase_core.dart';

//void main() => runApp(MyApp());

Future<void> main() async{

  final FirebaseApp app = await FirebaseApp.configure(
    name: 'yoga',
    options: Platform.isIOS
        ? const FirebaseOptions(
      googleAppID: '1:672552208046:android:add6664e60ba6ecd',
      gcmSenderID: '672552208046',
      databaseURL: 'https://yoga-9f994.firebaseio.com',
    )
        : const FirebaseOptions(
      googleAppID: '1:672552208046:android:6fdb7dd9b56e16e3',
      apiKey: 'AIzaSyBVjk0MfTaEJwV1GLrkG_ZBNBU5jNJBP3c',
      databaseURL: 'https://yoga-9f994.firebaseio.com',
    ),
  );


  runApp(MaterialApp(
    title: 'Yoga trainer  app',
    home: LandingView(app: app),
  ));


}

//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or simply save your changes to "hot reload" in a Flutter IDE).
//        // Notice that the counter didn't reset back to zero; the application
//        // is not restarted.
//        primarySwatch: Colors.blue,
//      ),
//      home: Login(title: 'Welcome'),
//    );
//  }
//}

