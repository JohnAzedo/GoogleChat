import 'package:chat/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'mixin_repository.dart';

class ChatRepository extends MixinRepository {
  ChatRepository() {
    this.COLLECTION_NAME = "messages";
  }

  Future<void> createMessage({required Message message}) async {
    this.getCollection().add(message.toJson());
  }

  Stream<QuerySnapshot<Object?>> streamMessage() {
    return this.getCollection().snapshots();
  }
}