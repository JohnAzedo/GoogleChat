import 'package:chat/models/message.dart';
import 'mixin_repository.dart';

class ChatRepository extends MixinRepository {
  ChatRepository() {
    this.COLLECTION_NAME = "messages";
  }

  Future<void> createMessage({required Message message}) async {
    this.getCollection().add(message.toJson());
  }


}