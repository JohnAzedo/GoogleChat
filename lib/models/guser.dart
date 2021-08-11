import 'package:flutter/cupertino.dart';

class GUser {
  final String uID;
  final String email;
  final String name;
  final String photoURL;

  GUser({@required this.uID, @required this.email, @required this.name, @required this.photoURL});

  GUser.fromJson(Map<String, dynamic> json):
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