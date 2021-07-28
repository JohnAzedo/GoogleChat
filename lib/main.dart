import 'package:chat/screens/auth.dart';
import 'package:chat/screens/chat/chat.dart';
import 'package:chat/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text('Connection error');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: AuthScreen(),
            theme: ThemeData(
              primarySwatch: Colors.teal,
              iconTheme: IconThemeData(
                color: Colors.teal
              )
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Text('Loading...', textDirection: TextDirection.ltr,);
      },
    );
  }
}

