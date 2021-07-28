import 'package:chat/screens/chat/chat.dart';
import 'package:chat/shared/utils.dart';
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
        builder: (context) => ChatScreen(),
      ),
    );
  }

  Future<User> _getUser() async {
    await signInWithGoogle();
    _navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _getUser,
            child: Text('Entrar com o google'),
          )
        ],
      ),
    );
  }
}
