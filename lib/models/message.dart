

import 'package:flutter/cupertino.dart';

class Message {
  static String COLLECTION_NAME = "messages";

  String id;
  String text;
  bool read;
  bool hasPhoto;
  String photoURL;
  String from;
  String to;
  DateTime time;

  Message({this.text, @required this.to, @required this.from, String photoURL}) {
    this.time = DateTime.now();
    if (photoURL != null) {
      hasPhoto = true;
      this.photoURL = photoURL;
    }
    this.read = false;
  }

  Message.fromJson(Map<String, dynamic> json):
      id = json['id'],
      text = json['text'],
      to = json['to'],
      from = json['from'],
      photoURL = json['photoURL'],
      read = json['read'],
      time = DateTime.fromMicrosecondsSinceEpoch(json['time']);


  Map<String, dynamic> toJson() => {
    'text': text,
    'time': time.microsecondsSinceEpoch,
    'to': to,
    'from': from,
    'photoURL': photoURL,
    'read': read,
  };






}

