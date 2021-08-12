import 'package:chat/models/guser.dart';
import 'package:chat/repositories/mixin_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class GUserRepository extends MixinRepository{
  GUserRepository(){
    this.COLLECTION_NAME = "users";
  }

  Future<QuerySnapshot<Object?>> searchUserById({required String? id}) async{
    return this.getCollection().where('uid', isEqualTo: id).limit(1).get();

  }

  Future<void> createUser({required GUser user}) async{
    final querySnapShot = await this.searchUserById(id: user.uID);
    if(querySnapShot.docs.isEmpty){
      this.getCollection().add(user.toJson());
    }
  }
}