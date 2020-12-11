import 'package:cloud_firestore/cloud_firestore.dart';

class BaseFireStoreModel {
  String id;

  BaseFireStoreModel({this.id});
  T extractValue<T>(DocumentSnapshot doc, String key) {
    if (doc.data().containsKey(key)) {
      return doc.data()[key] as T;
    }
    return null;
  }
}
