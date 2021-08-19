import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  late final int index;
  late final String photoURL;
  late final String name;
  late final String? lastMessage;
  final isMessageRead = false;
  final Function onTap;

  ListItem(
      {required this.index,
        required this.photoURL,
        required this.name,
        this.lastMessage,
        required this.onTap});

  Widget TextWidget() {
    return Text(
      this.lastMessage!,
      style: TextStyle(
          fontSize: 13,
          color: Colors.grey.shade600,
          fontWeight: isMessageRead ? FontWeight.bold : FontWeight.normal),
    );
  }

  Widget DataWidget() {
    return Text(
      "Today",
      style: TextStyle(
          fontSize: 12,
          fontWeight: isMessageRead ? FontWeight.bold : FontWeight.normal),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: this.onTap(),
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(photoURL),
                    maxRadius: 30,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          if (this.lastMessage != null) TextWidget()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (this.lastMessage != null) DataWidget()
          ],
        ),
      ),
    );
  }
}