import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

Future<String> uploadPickedFile(PickedFile file) async{
  UploadTask task = FirebaseStorage.instance
      .ref()
      .child(DateTime.now().millisecondsSinceEpoch.toString())
      .putFile(File(file.path));

  TaskSnapshot snapshot = await task;
  return await snapshot.ref.getDownloadURL();
}

Future<UserCredential> signInWithGoogle() async{
  final GoogleSignInAccount? account = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication authentication = await account!.authentication;
  final credential = GoogleAuthProvider.credential(
      accessToken: authentication.accessToken,
      idToken: authentication.idToken
  );
  return await FirebaseAuth.instance.signInWithCredential(credential);
}