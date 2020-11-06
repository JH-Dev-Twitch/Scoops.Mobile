import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoops/core/data/models/base_fireStore_model.dart';

class BaseFireStoreService {
  /// Retrieves a list of items of type [T] from the firestore collection [collection].
  ///
  /// [collection] refers to the name of the firestore collection.
  ///
  /// [T] refers to the return type of the method.
  ///
  /// [mapping] is a function used to map from a document to the target type of [T].
  ///
  /// Throws the relevant Firestore exceptions
  Future<List<T>> retrieveListAsync<T extends BaseFireStoreModel>(
      String collection, T Function(QueryDocumentSnapshot doc) mapping) async {
    //calls table
    CollectionReference beverageGroups =
        FirebaseFirestore.instance.collection(collection);
    //retrieves the data
    var groups = await beverageGroups.get();
    if (groups.size > 0) {
      //maps to a class
      return groups.docs.map<T>(mapping).toList();
    }
    return new List<T>.empty();
  }
}
