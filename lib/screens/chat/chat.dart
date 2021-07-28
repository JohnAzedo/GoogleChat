import 'dart:io';

import 'package:chat/shared/progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'message_field.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void _sendMessage({String text, PickedFile file}) async {
    Map<String, dynamic> data = {};
    data['from'] = "João";

    if (file != null) {
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(File(file.path));

      TaskSnapshot snapshot = await task;
      data['url'] = await snapshot.ref.getDownloadURL();
      data['isPhoto'] = true;
    }

    if (text != null) {
      data['text'] = text;
      data['isPhoto'] = false;
    }

    FirebaseFirestore.instance.collection("message").add(data);
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
                        .collection("message")
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
                            reverse: false,
                            itemBuilder: (context, index){
                              String text = 'URL';
                              var document = documents[index];
                              if(!document.get('isPhoto')){
                                text = document.get('text');
                              }

                              return ListTile(
                                title: Text(text),
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
