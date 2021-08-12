
import 'package:chat/models/guser.dart';
import 'package:chat/shared/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Credential {
  late final UserCredential _userCredential;

  Future<void> _getCredential() async {
    this._userCredential = await signInWithGoogle();
  }

  Future<GUser> getGUser() async {
    await _getCredential();
    return GUser(
        uID: this._userCredential.user!.uid,
        email: this._userCredential.user!.email,
        name: this._userCredential.user!.displayName,
        photoURL: this._userCredential.user!.photoURL
    );
  }
}