import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoops/core/constants/database_collections.dart';
import 'package:scoops/core/data/models/establishment.dart';
import 'package:scoops/core/data/models/establishmentType.dart';
import 'package:scoops/core/services/base_firestore_service.dart';

class EstablishmentService extends BaseFireStoreService {
  Future<List<EstablishmentType>> loadEstablishmentTypesAsync() async {
    var groups = await getAllFromCollectionAsync<EstablishmentType>(
        DatabaseCollections.establishment_types,
        (doc) => EstablishmentType(id: doc.id, name: doc['name']));
    return groups;
  }

  Future<List<Establishment>> loadEstablishmentsAsync() async =>
      await getAllFromCollectionAsync<Establishment>(
          DatabaseCollections.establishments, (doc) => mapEstablishment(doc));

  Establishment mapEstablishment(QueryDocumentSnapshot doc) => Establishment(
      id: doc.id,
      name: doc['name'],
      imageUrl: doc['imageUrl'],
      rating: mapRating(doc['rating'] as Map),
      locationInfo: mapLocation(doc['location_info'] as Map),
      amenities: mapList(doc['amenities'] as List),
      establishmentType: doc['type']);
  //socialAccounts: mapSocial(doc['social'] as List));

  EstablishmentRatingSummary mapRating(Map rating) =>
      EstablishmentRatingSummary(
          ratings: rating['count'] as int,
          overallRating: rating['score'] as double);

  EstablishmentLocationInfo mapLocation(Map location) =>
      EstablishmentLocationInfo(
          city: location['city'],
          country: location['country'],
          latitude: location['latitude'] as double,
          longitude: location['longitude'] as double,
          mapsUrl: location['mapsUrl']);

  List<String> mapList(List<dynamic> list) =>
      list.map((e) => e as String).toList();
  List<SocialAccount> mapSocial(List<dynamic> list) =>
      list.map((e) => mapAccount(e as Map)).toList();
  SocialAccount mapAccount(Map doc) => SocialAccount(doc['name'], doc['url']);
}
