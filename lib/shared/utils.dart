import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

Future<String> uploadPickedFile(PickedFile file) async{
  UploadTask task = FirebaseStorage.instance
      .ref()
      .child(DateTime.now().millisecondsSinceEpoch.toString())
      .putFile(File(file.path));

  TaskSnapshot snapshot = await task;
  return await snapshot.ref.getDownloadURL();
}