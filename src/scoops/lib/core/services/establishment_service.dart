import 'package:scoops/core/constants/database_collections.dart';
import 'package:scoops/core/data/models/establishmentType.dart';
import 'package:scoops/core/services/base_firestore_service.dart';

class EstablishmentService extends BaseFireStoreService {
  Future<List<EstablishmentType>> loadEstablishmentTypesAsync() async {
    var groups = await retrieveListAsync<EstablishmentType>(
        DatabaseCollections.establishment_types,
        (doc) => EstablishmentType(id: doc.id, name: doc['name']));
    return groups;
  }
}
