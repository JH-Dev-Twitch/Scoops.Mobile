import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoops/core/data/models/beverageGroup.dart';

class BeverageService {
  Future<List<BeverageGroup>> getBeverageGroupsAsync() async {
    var list = List<BeverageGroup>();
    CollectionReference beverageGroups =
        FirebaseFirestore.instance.collection('beverage_groups');
    var groups = await beverageGroups.get();
    if (groups.size > 0) {
      groups.docs.forEach((doc) {
        list.add(BeverageGroup(
            id: doc.id, name: doc['name'], imageUrl: doc['imageUrl']));
      });
    }

    return list;
  }
}
