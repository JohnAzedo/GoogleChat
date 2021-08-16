import 'package:chat/controllers/credential.dart';
import 'package:chat/models/guser.dart';
import 'package:chat/repositories/guser_repository.dart';
import 'package:chat/screens/home/home_screen.dart';
import 'package:chat/shared/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat/chat_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
    );
  }

  void _signIn() async {
    final GUser user = await Credential().getGUser();
    final repository = GUserRepository();
    await repository.createUser(user: user);
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
