import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MessageFieldComposer extends StatefulWidget {

  MessageFieldComposer(this.sendMessage);
  final Function({String text, PickedFile file}) sendMessage;

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
    widget.sendMessage(text: controller.text);
    controller.clear();
    isTyping = false;
  }

  _cameraAction() async{
    final PickedFile file = await ImagePicker.platform.pickImage(source: ImageSource.camera);
    if(file == null) return;
    widget.sendMessage(file: file);
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