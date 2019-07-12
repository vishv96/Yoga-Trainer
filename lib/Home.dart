import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Home extends StatefulWidget{

  Home({this.user,this.app}) : super();
  final FirebaseUser user;
  final FirebaseApp app;

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home>{


  Future getlevels() async{
    var firestore = Firestore.instance;
    QuerySnapshot qs = await firestore.collection("levels").getDocuments();
    return qs.documents;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.user.displayName)
      ),
      body: Padding(padding: EdgeInsets.all(10),
        child:Center(
          child:  FutureBuilder(
              future: getlevels(),
              builder: (_,snapshot){

                if (snapshot.data == null){
                  if (snapshot.hasError){
                    Text("Something went wrong :(");
                  }else{
                    Text("Loading..");
                  }
                }else{
                  //Here it will build the list

                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_,index){
                        return ListTile(
                          title: Text(snapshot.data[index].data["levelname"].toString()),
                        );

                      });

                }
              }
          ),
        )
      ),
    );
  }

}