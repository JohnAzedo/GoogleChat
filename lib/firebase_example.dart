import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Example extends StatelessWidget {

  _getDocuments() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("message").get();
    snapshot.docs.forEach((element) {
      element.reference.update({"read":true});
    });
  }

  _listenDocuments() {
    FirebaseFirestore.instance.collection("message").snapshots().listen((event) {
      event.docs.forEach((element) {
        print(element.data());
      });
    });
  }

  _setData() {
    FirebaseFirestore.instance
        .collection("message")
        .doc()
        .set({"text": "Hello"});
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
          _listenDocuments();

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                title: Text('LemonChat'),
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

