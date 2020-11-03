import 'package:cloud_firestore/cloud_firestore.dart';

class BaseFireStoreService<T> {
  /// Retrieves a list of items of type [T] from the firestore collection [collection].
  ///
  /// [collection] refers to the name of the firestore collection.
  ///
  /// [T] refers to the return type of the method.
  ///
  /// [mapping] is a function used to map from a document to the target type of [T].
  ///
  /// Throws the relevant Firestore exceptions
  Future<List<T>> retrieveListAsync(
      String collection, T Function(QueryDocumentSnapshot doc) mapping) async {
    var list = List<T>();
    CollectionReference beverageGroups =
        FirebaseFirestore.instance.collection(collection);
    var groups = await beverageGroups.get();
    if (groups.size > 0) {
      groups.docs.forEach((doc) => list.add(mapping(doc)));
    }
    return list;
  }
}
