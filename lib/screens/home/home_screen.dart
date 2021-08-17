import 'package:chat/screens/user/user_screen.dart';
import 'package:flutter/material.dart';
import 'chat_listview.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _navigateToUsersList() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UserListScreen(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: ChatsListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: _navigateToUsersList,
      ),
    );
  }
}
