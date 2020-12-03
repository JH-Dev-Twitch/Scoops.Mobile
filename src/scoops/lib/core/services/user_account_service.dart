import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoops/core/constants/database_collections.dart';
import 'package:scoops/core/data/user/user_preferences.dart';

class UserAccountService {
  Future<UserPreferences> getUserSettings() async {
    var doc = await FirebaseFirestore.instance
        .collection(DatabaseCollections.userProfiles)
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    return doc.exists ? UserPreferences.mapFromDoc(doc) : null;
  }

  Future createEmptyPrefs() async {
    var _emptyPrefs = UserPreferences.empty();
    await FirebaseFirestore.instance
        .collection(DatabaseCollections.userProfiles)
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set(_emptyPrefs.convertToDocMap());
  }

  Future<bool> savePreferences(UserPreferences prefs) async {
    await FirebaseFirestore.instance
        .collection(DatabaseCollections.userProfiles)
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update(prefs.convertToDocMap());
    return true;
  }
}
