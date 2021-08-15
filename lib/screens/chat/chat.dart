import 'package:chat/controllers/chat_controller.dart';
import 'package:chat/models/message.dart';
import 'package:chat/repositories/chat_repository.dart';
import 'package:chat/shared/progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'message_field.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  User? _currentUser;
  late final ChatController _controller;
  late final ChatRepository _repository;

  @override
  void initState() {
    super.initState();
    this._currentUser = FirebaseAuth.instance.currentUser;
    this._repository = ChatRepository();
    this._controller = ChatController(this._currentUser!, this._repository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Luka Doncic"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: this._repository.streamMessage(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return WaitIndicator();
                        default:
                          List<DocumentSnapshot> documents = snapshot.data!.docs;
                          return ListView.builder(
                            itemCount: documents.length,
                            itemBuilder: (context, index){
                              var message = Message.fromJson(documents[index].data() as Map<String, dynamic>);
                              return ListTile(
                                title: Text(message.text!),
                              );
                            },
                          );
                      }
                    }),
              ),
              MessageFieldComposer(
                this._controller,
              ),
            ],
          ),
        ));
  }
}
