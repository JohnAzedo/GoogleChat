import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MixinRepository {

  late final String COLLECTION_NAME;

  CollectionReference getCollection(){
    return FirebaseFirestore.instance.collection(COLLECTION_NAME);
  }

}