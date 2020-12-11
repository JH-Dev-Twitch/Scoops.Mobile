import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoops/core/data/models/base_fireStore_model.dart';

class OSSContribution extends BaseFireStoreModel {
  String name;
  String owner;
  String description;
  String link;
  String type;
  OSSContribution(
      {String id,
      this.name,
      this.owner,
      this.type,
      this.description,
      this.link})
      : super(id: id);

  OSSContribution.fromDocument(DocumentSnapshot document) {
    if (!document.exists) {
      //defaults maybe?
    } else {
      this.id = document.id;
      this.name = extractValue(document, "name");
      this.owner = extractValue(document, "owner");
      this.description = extractValue(document, "description");
      this.link = extractValue(document, "link");
      this.type = extractValue(document, "type");
    }
  }

  Map<String, dynamic> toDocumentMap() {
    var map = {
      'name': this.name,
      'owner': this.owner,
      'description': this.description,
      'link': this.link,
      'type': this.type
    };
    return map;
  }
}
