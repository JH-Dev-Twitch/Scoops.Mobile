import 'package:scoops/core/constants/database_collections.dart';
import 'package:scoops/core/data/models/beverageGroup.dart';
import 'package:scoops/core/services/base_firestore_service.dart';

class BeverageService extends BaseFireStoreService {
  Future<List<BeverageGroup>> getBeverageGroupsAsync() async =>
      await getAllFromCollectionAsync<BeverageGroup>(
          DatabaseCollections.beverage_groups, (doc) {
        return BeverageGroup(
            id: doc.id,
            name: doc['name'],
            imageUrl: doc.data().containsKey('imageUrl')
                ? doc['imageUrl']
                : 'https://p2d7x8x2.stackpathcdn.com/wordpress/wp-content/uploads/2017/07/round-of-drinks-640x427.jpg');
      });
}
