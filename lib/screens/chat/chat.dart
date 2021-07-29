import 'package:chat/models/message.dart';
import 'package:chat/shared/progress_indicator.dart';
import 'package:chat/shared/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'message_field.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  User _currentUser;

  void _sendMessage({String text, PickedFile file}) async {
    var message = Message(to: _currentUser.displayName, from: 'Lemmon');
    if (file != null) {
      message.photoURL = await uploadPickedFile(file);
    }

    if (text != null) {
      message.text = text;
    }
    FirebaseFirestore.instance.collection(Message.COLLECTION_NAME).add(message.toJson());
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.userChanges().listen((user) {
      _currentUser = user;
    });
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
                    stream: FirebaseFirestore.instance
                        .collection(Message.COLLECTION_NAME)
                        .snapshots(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return WaitIndicator();
                        default:
                          List<DocumentSnapshot> documents = snapshot.data.docs;
                          return ListView.builder(
                            itemCount: documents.length,
                            itemBuilder: (context, index){
                              var message = Message.fromJson(documents[index].data());
                              return ListTile(
                                title: Text(message.text),
                              );
                            },
                          );
                      }
                    }),
              ),
              MessageFieldComposer(
                _sendMessage,
              ),
            ],
          ),
        ));
  }
}
