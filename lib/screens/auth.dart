import 'package:chat/controllers/credential.dart';
import 'package:chat/models/guser.dart';
import 'package:chat/repositories/users.dart';
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
    final GUser user = await Credential().getGUser();
    final repository = GUserRepository();
    final queryShot = await repository.searchUserById(id: user.uID);
    if(queryShot.docs.isEmpty){
      await repository.createUser(user: user);
    }
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
