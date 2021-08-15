import 'package:chat/models/chat.dart';
import 'package:chat/repositories/chat_repository.dart';
import 'package:chat/shared/progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'chat/chat_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: ChatsListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: () => {},
      ),
    );
  }
}


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
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  itemCount: documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    var chat = Chat.fromJson(documents[index].data() as Map<String, dynamic>);
                    return ListItem(
                      index: index,
                      photoURL: chat.photoURL!,
                      name: chat.name!,
                      lastMessage: "This is a test!",
                    );
                  });
          }
        });
  }
}


class ListItem extends StatelessWidget {
  late final int index;
  late final String photoURL;
  late final String name;
  late final String lastMessage;
  final isMessageRead = true;

  ListItem({required this.index, required this.photoURL, required this.name, required this.lastMessage});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(photoURL),
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(name, style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6,),
                          Text(lastMessage,style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: isMessageRead?FontWeight.bold:FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text("Today",style: TextStyle(fontSize: 12,fontWeight: isMessageRead?FontWeight.bold:FontWeight.normal),),
          ],
        ),
      ),
    );
  }

}