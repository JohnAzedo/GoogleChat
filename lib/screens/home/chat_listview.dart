import 'package:chat/models/chat.dart';
import 'package:chat/repositories/chat_repository.dart';
import 'package:chat/shared/chat_item.dart';
import 'package:chat/shared/progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatsListView extends StatefulWidget {
  @override
  _ChatsListViewState createState() => _ChatsListViewState();
}

class _ChatsListViewState extends State<ChatsListView> {
  late final ChatRepository repository;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    repository = new ChatRepository();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: this.repository.streamChats(),
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
                    var chat = Chat.fromJson(
                        documents[index].data() as Map<String, dynamic>);
                    debugPrint(chat.toString());
                    return ListItem(
                      index: index,
                      photoURL: chat.photoURL!,
                      name: chat.name!,
                      lastMessage: "This is a test!",
                      onTap: (){},
                    );
                  });
          }
        });
  }
}
