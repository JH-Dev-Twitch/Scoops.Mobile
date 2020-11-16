import 'package:scoops/core/data/models/base_fireStore_model.dart';

class Amenity extends BaseFireStoreModel {
  String name;
  Amenity({id, this.name}) : super(id: id);
}
