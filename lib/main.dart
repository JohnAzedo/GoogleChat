import 'package:chat/repositories/guser_repository.dart';
import 'package:chat/screens/auth_screen.dart';
import 'package:chat/screens/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(App());
}

class App extends StatelessWidget {
  final repository = GUserRepository();

  Widget route() {
    if(repository.getCurrentUser() != null){
      return Home();
    } else {
      return AuthScreen();
    }
  }

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
            home: route(),
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

