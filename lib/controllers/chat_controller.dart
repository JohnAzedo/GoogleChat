import 'package:chat/models/message.dart';
import 'package:chat/repositories/chat_repository.dart';
import 'package:chat/shared/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class ChatController{
  late final User user;
  late final ChatRepository repository;

  ChatController(User user, ChatRepository repository) {
    this.user = user;
    this.repository = repository;
  }

  Future<void> sendMessage({String? text, PickedFile? file}) async {
    var message = Message(to: user.displayName, from: 'Lemmon');

    if (file != null) {
      message.photoURL = await uploadPickedFile(file);
    }
    if (text != null) {
      message.text = text;
    }

    this.repository.createMessage(message: message);
  }
}
