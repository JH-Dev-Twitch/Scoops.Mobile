import 'package:scoops/core/constants/database_collections.dart';
import 'package:scoops/core/data/models/beverageGroup.dart';
import 'package:scoops/core/services/base_firestore_service.dart';

class BeverageService extends BaseFireStoreService {
  Future<List<BeverageGroup>> getBeverageGroupsAsync() async =>
      await retrieveListAsync<BeverageGroup>(
          DatabaseCollections.beverage_groups, (doc) {
        return BeverageGroup(
            id: doc.id, name: doc['name'], imageUrl: doc['imageUrl']);
      });
}
