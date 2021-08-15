import 'package:chat/models/guser.dart';
import 'package:chat/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mixin_repository.dart';

class ChatRepository extends MixinRepository {
  ChatRepository() {
    this.COLLECTION_NAME = "chats";
  }

  Future<void> createMessage({required Message message}) async {
    this.getCollection().doc().collection("messages").add(message.toJson());
  }

  Stream<QuerySnapshot<Object?>> streamMessage() {
    return this.getCollection().snapshots();
  }


  Stream<QuerySnapshot<Object?>> streamChats() {
    return this.getCollection().snapshots();
  }

}