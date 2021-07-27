import 'dart:io';

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
  void _sendMessage({String text, PickedFile file}) async{
    if(file != null){
      UploadTask task = FirebaseStorage.instance.ref().child(
          DateTime.now().millisecondsSinceEpoch.toString()
      ).putFile(File(file.path));


      TaskSnapshot snapshot = await task;
      text = await snapshot.ref.getDownloadURL();
    }

    var data = {"from": "João", "text": text};
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
        child: MessageFieldComposer(
            _sendMessage,
        ),
      )
    );
  }
}
