import 'package:chat/models/guser.dart';
import 'package:chat/repositories/guser_repository.dart';
import 'package:chat/shared/chat_item.dart';
import 'package:chat/shared/progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final repository = GUserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: this.repository.getUsers(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return WaitIndicator();
              default:
                List<DocumentSnapshot> documents = snapshot.data!.docs;
                return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                    itemCount: documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      var user = GUser.fromJson(documents[index].data() as Map<String, dynamic>);
                      return ListItem(
                        index: index,
                        photoURL: user.photoURL!,
                        name: user.name!,
                        onTap: (){},
                      );
                    });
            }
          }),
    );
  }
}


