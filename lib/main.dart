import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(App());
}

class App extends StatelessWidget {

  _getDocuments() async {
    print("Debug: In _getDocuments");
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("message").get().then((value){
      print(value.docs.length);
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text('Connection error');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {

          // FirebaseFirestore.instance
          //     .collection("message")
          //     .doc()
          //     .set({"text": "Hello"});
          _getDocuments();


          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                title: Text('FireChat'),
              ),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Text('Loading...', textDirection: TextDirection.ltr,);
      },
    );
  }
}

