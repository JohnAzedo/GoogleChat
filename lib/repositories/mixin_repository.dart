import 'package:cloud_firestore/cloud_firestore.dart';

class MixinRepository {
  String? _COLLECTION_NAME;

  // Generic
  CollectionReference _getCollection(){
    return FirebaseFirestore.instance.collection(_COLLECTION_NAME!);
  }

  // Generic
  String? getCollectionName(){
    return _COLLECTION_NAME;
  }
}