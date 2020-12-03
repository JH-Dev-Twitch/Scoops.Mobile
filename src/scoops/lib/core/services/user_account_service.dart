import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoops/core/constants/database_collections.dart';

class UserAccountService {
  Future<UserPreferences> getUserSettings() async {
    var doc = await FirebaseFirestore.instance
        .collection(DatabaseCollections.userProfiles)
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    return doc.exists ? mapToPreferences(doc) : null;
  }

  Future createEmptyPrefs() async {
    var _emptyPrefs = UserPreferences.empty();
    await FirebaseFirestore.instance
        .collection(DatabaseCollections.userProfiles)
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set(_emptyPrefs.convertToDocMap());
  }

  UserPreferences mapToPreferences(DocumentSnapshot doc) {
    var amenities = doc['amenities'] as List;
    var groups = doc['beverage_groups'] as List;
    var establishmentTypes = doc['establishment_types'] as List;
    return UserPreferences(
        amenities: amenities.map((e) => e as String).toList(),
        beverageGroups: groups.map((e) => e as String).toList(),
        establishmentTypes:
            establishmentTypes.map((e) => e as String).toList());
  }

  Future<bool> savePreferences(UserPreferences prefs) async {
    try {} catch (e) {}
    await FirebaseFirestore.instance
        .collection(DatabaseCollections.userProfiles)
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update(prefs.convertToDocMap());
    return true;
  }

  Map<String, List<dynamic>> mapPrefs(UserPreferences) => {};
}

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

  Map<String, List<dynamic>> convertToDocMap() {
    return {
      'amenities': this.amenities,
      'establishment_types': this.establishmentTypes,
      'beverage_groups': this.beverageGroups
    };
  }
}
