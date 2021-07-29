import 'package:flutter/cupertino.dart';

class CustomUser {
  static String COLLECTION_NAME = "users";

  final String uID;
  final String email;
  final String name;
  final String photoURL;

  CustomUser({@required this.uID, @required this.email, @required this.name, @required this.photoURL});

  CustomUser.fromJson(Map<String, dynamic> json):
        uID = json['uid'],
        email = json['email'],
        name = json['name'],
        photoURL = json['photoURL'];


  Map<String, dynamic> toJson() => {
    'uid': uID,
    'email': email,
    'name': name,
    'photoURL': photoURL,
  };
}