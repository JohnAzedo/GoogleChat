import 'package:chat/models/user.dart';
import 'package:chat/screens/home.dart';
import 'package:chat/shared/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void _navigateToHome() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
    );
  }

  void _signIn() async {
    final UserCredential credential = await signInWithGoogle();
    var user = CustomUser(
        uID: credential.user.uid,
        email: credential.user.email,
        name: credential.user.displayName,
        photoURL: credential.user.photoURL
    );

    // Change this
    FirebaseFirestore.instance
        .collection(CustomUser.COLLECTION_NAME)
        .where('uid', isEqualTo: user.uID).limit(1).get()
        .then((QuerySnapshot query) {
          if(query.docs.isEmpty){
            FirebaseFirestore.instance.collection(CustomUser.COLLECTION_NAME).add(user.toJson());
          }
        });
    _navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _signIn,
            child: Text('Entrar com o google'),
          )
        ],
      ),
    );
  }
}
