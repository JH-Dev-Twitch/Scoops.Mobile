import 'package:scoops/core/data/models/base_fireStore_model.dart';

class BeverageGroup extends BaseFireStoreModel {
  String name;
  String imageUrl;

  BeverageGroup({String id, this.name, this.imageUrl}) : super(id: id);
}
