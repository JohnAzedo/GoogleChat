import 'dart:io';

import 'package:chat/controllers/chat_controller.dart';
import 'package:chat/repositories/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MessageFieldComposer extends StatefulWidget {

  MessageFieldComposer(ChatController this.controller);
  final ChatController controller;

  @override
  _MessageFieldComposerState createState() => _MessageFieldComposerState();
}

class _MessageFieldComposerState extends State<MessageFieldComposer> {

  bool _isTyping = false;
  void set isTyping(bool value){
    setState(() {
      _isTyping = value;
    });
  }

  final controller = TextEditingController();

  _sendAction(){
    widget.controller.sendMessage(text: controller.text);
    controller.clear();
    isTyping = false;
  }

  _cameraAction() async{
    final PickedFile? file = await ImagePicker.platform.pickImage(source: ImageSource.camera);
    if(file == null) return;
    await widget.controller.sendMessage(file: file);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: _cameraAction,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration.collapsed(hintText: "Enviar uma mensagem"),
              onChanged: (text) {
                isTyping = text.isNotEmpty;
              },
              controller: controller,
              onSubmitted: (text) => _sendAction(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _isTyping ? _sendAction : null,
          )
        ],
      ),
    );
  }
}