import 'package:scoops/core/constants/database_collections.dart';
import 'package:scoops/core/data/models/oss_contribution.dart';
import 'package:scoops/core/services/base_firestore_service.dart';

class OSSContributionsService extends BaseFireStoreService {
  Future<List<OSSContribution>> loadContributionsAsync() async =>
      await getAllFromCollectionAsync<OSSContribution>(
          DatabaseCollections.ossContribs,
          (doc) => OSSContribution.fromDocument(doc));
}
