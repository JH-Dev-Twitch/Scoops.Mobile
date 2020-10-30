import 'dart:core';

class Establishment {
  String name;
  String establishmentType;
  String imageUrl;
  List<String> amenities;
  EstablishmentRatingSummary rating;

  Establishment(
      {this.name,
      this.imageUrl,
      this.establishmentType,
      this.rating,
      this.amenities});
}

class EstablishmentRatingSummary {
  double overallRating;
  int ratings;
  EstablishmentRatingSummary({this.ratings, this.overallRating});
}
