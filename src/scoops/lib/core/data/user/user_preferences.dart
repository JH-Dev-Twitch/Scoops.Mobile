import 'package:cloud_firestore/cloud_firestore.dart';

class UserPreferences {
  List<String> amenities;
  List<String> establishmentTypes;
  List<String> beverageGroups;

  UserPreferences(
      {this.amenities, this.beverageGroups, this.establishmentTypes});

  UserPreferences.empty() {
    this.amenities = List<String>.empty();
    this.establishmentTypes = List<String>.empty();
    this.beverageGroups = List<String>.empty();
  }

  UserPreferences.mapFromDoc(DocumentSnapshot doc) {
    var _amenities = doc['amenities'] as List;
    var _groups = doc['beverage_groups'] as List;
    var _establishmentTypes = doc['establishment_types'] as List;
    this.amenities = _amenities.map((e) => e as String).toList();
    this.beverageGroups = _groups.map((e) => e as String).toList();
    this.establishmentTypes =
        _establishmentTypes.map((e) => e as String).toList();
  }

  Map<String, List<dynamic>> convertToDocMap() {
    return {
      'amenities': this.amenities,
      'establishment_types': this.establishmentTypes,
      'beverage_groups': this.beverageGroups
    };
  }
}
