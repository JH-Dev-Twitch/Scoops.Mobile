import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DocumentModel<T> {
  void fromDocument(DocumentSnapshot doc);
  Map<String, dynamic> toDocumentMap();
}
