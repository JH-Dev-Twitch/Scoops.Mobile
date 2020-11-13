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
  Future<List<T>> getAllFromCollectionAsync<T extends BaseFireStoreModel>(
      String collectionName,
      T Function(QueryDocumentSnapshot doc) mapping) async {
    //calls table
    CollectionReference collection = getCollection(collectionName);

    //retrieves the data
    var groups = await collection.get();
    if (groups.size > 0) {
      //maps to a class
      return groups.docs.map<T>(mapping).toList();
    }
    return new List<T>.empty();
  }

  Future<List<T>> queryCollectionAsync<T extends BaseFireStoreModel>(
      String collectionName,
      FireStoreFilter filter,
      T Function(QueryDocumentSnapshot doc) mapping) async {
    //calls table
    CollectionReference collection = getCollection(collectionName);
    //retrieves the data
    var groups = await collection.applyFilter(filter).get();
    if (groups.size > 0) {
      //maps to a class
      return groups.docs.map<T>(mapping).toList();
    }
    return new List<T>.empty();
  }

  CollectionReference getCollection(String collectionName) =>
      FirebaseFirestore.instance.collection(collectionName);
}

class FireStoreFilter {
  dynamic field;
  Expression expression;
  dynamic value;

  FireStoreFilter({this.field, this.expression, this.value});
}

enum Expression {
  IsEqualTo,
  IsNotEqualTo,
  IsLessThan,
  IsLessThanOrEqualTo,
  IsGreaterThan,
  IsGreaterThanOrEqualTo,
  ArrayContains,
  ArrayContainsAny,
  WhereIn,
  WhereNotIn,
  IsNull
}

extension ApplyFilter on CollectionReference {
  Query applyFilter(FireStoreFilter filter) {
    switch (filter.expression) {
      case Expression.IsEqualTo:
        return this.where(filter.field, isEqualTo: filter.value);
      case Expression.IsNotEqualTo:
        return this.where(filter.field, isNotEqualTo: filter.value);
      case Expression.ArrayContains:
        return this.where(filter.field, arrayContains: filter.value);
      case Expression.ArrayContainsAny:
        return this.where(filter.field, arrayContainsAny: filter.value);
      case Expression.IsGreaterThan:
        return this.where(filter.field, isGreaterThan: filter.value);
      case Expression.IsGreaterThanOrEqualTo:
        return this.where(filter.field, isGreaterThanOrEqualTo: filter.value);
      case Expression.IsLessThan:
        return this.where(filter.field, isLessThan: filter.value);
      case Expression.IsLessThanOrEqualTo:
        return this.where(filter.field, isLessThanOrEqualTo: filter.value);
      case Expression.WhereIn:
        return this.where(filter.field, whereIn: filter.value);
      case Expression.WhereNotIn:
        return this.where(filter.field, whereNotIn: filter.value);
      case Expression.IsNull:
        return this.where(filter.field, isNull: filter.value);
      default:
        throw Exception('invalid Filter');
    }
  }
}
