import 'package:chat/models/guser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class GUserRepository {
  // Generic
  final String _COLLECTION_NAME = "users";

  Future<QuerySnapshot<Object>> searchUserById({@required String id}) async{
    return _getCollection().where('uid', isEqualTo: id).limit(1).get();
  }

  Future<DocumentReference<Object>> createUser({@required GUser user}) async{
    return _getCollection().add(user.toJson());
  }

  // Generic
  CollectionReference _getCollection(){
    return FirebaseFirestore.instance.collection(_COLLECTION_NAME);
  }

  // Generic
  String getCollectionName(){
    return _COLLECTION_NAME;
  }
}