import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoops/core/data/models/base_fireStore_model.dart';

class UserPreferences extends BaseFireStoreModel {
  List<String> amenities;
  List<String> establishmentTypes;
  List<String> beverageGroups;

  UserPreferences();

  UserPreferences.populate(
      {String id, this.amenities, this.beverageGroups, this.establishmentTypes})
      : super(id: id);

  UserPreferences.empty() {
    this.amenities = List<String>.empty();
    this.establishmentTypes = List<String>.empty();
    this.beverageGroups = List<String>.empty();
  }

  UserPreferences mapFromDoc(DocumentSnapshot doc) {
    var _amenities = doc['amenities'] as List;
    var _groups = doc['beverage_groups'] as List;
    var _establishmentTypes = doc['establishment_types'] as List;
    this.amenities = _amenities.map((e) => e as String).toList();
    this.beverageGroups = _groups.map((e) => e as String).toList();
    this.establishmentTypes =
        _establishmentTypes.map((e) => e as String).toList();
    return this;
  }

  Map<String, List<dynamic>> convertToDocMap() {
    return {
      'amenities': this.amenities,
      'establishment_types': this.establishmentTypes,
      'beverage_groups': this.beverageGroups
    };
  }
}
