import 'dart:core';

import 'package:scoops/core/data/models/base_fireStore_model.dart';

class Establishment extends BaseFireStoreModel {
  String name;
  String establishmentType;
  String imageUrl;
  List<String> amenities;
  EstablishmentRatingSummary rating;
  EstablishmentLocationInfo locationInfo;
  List<SocialAccount> socialAccounts;

  Establishment(
      {id,
      this.name,
      this.imageUrl,
      this.establishmentType,
      this.rating,
      this.amenities,
      this.locationInfo,
      this.socialAccounts})
      : super(id: id);
}

class EstablishmentRatingSummary {
  double overallRating;
  int ratings;
  EstablishmentRatingSummary({this.ratings, this.overallRating});
}

class EstablishmentLocationInfo {
  String city;
  String country;
  String mapsUrl;
  double latitude;
  double longitude;

  EstablishmentLocationInfo(
      {this.city, this.country, this.latitude, this.longitude, this.mapsUrl});
}

class SocialAccount {
  final String name;
  final String url;

  SocialAccount(this.name, this.url);
}
