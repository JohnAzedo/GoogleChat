import 'package:flutter/material.dart';

class MessageFieldComposer extends StatefulWidget {

  MessageFieldComposer(this.sendMessage);
  Function(String) sendMessage;

  @override
  _MessageFieldComposerState createState() => _MessageFieldComposerState();
}

class _MessageFieldComposerState extends State<MessageFieldComposer> {

  bool _isTyping = false;
  final controller = TextEditingController();
  void set isTyping(bool value){
    setState(() {
      _isTyping = value;
    });
  }

  _action(){
    widget.sendMessage(controller.text);
    controller.clear();
    isTyping = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration.collapsed(hintText: "Enviar uma mensagem"),
              onChanged: (text) {
                isTyping = text.isNotEmpty;
              },
              controller: controller,
              onSubmitted: (text) => _action(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _isTyping ? _action : null,
          )
        ],
      ),
    );
  }
}