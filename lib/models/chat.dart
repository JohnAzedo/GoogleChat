
import 'package:chat/models/guser.dart';
import 'package:chat/models/message.dart';

class Chat {
  final List<dynamic> users;
  final String? name;
  final String? photoURL;
  final List<Message>? messages;

  Chat({required this.users, this.name, this.photoURL, this.messages});

  Chat.fromJson(Map<String, dynamic> json):
        users = json['users'],
        name = json['name'],
        photoURL = json['photoURL'],
        messages = json['messages'];


  Map<String, dynamic> toJson() => {
    'users': users,
    'name': name,
    'photoURL': photoURL,
    'messages': messages,
  };
}