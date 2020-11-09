import 'package:flutter_test/flutter_test.dart';
import 'package:geocoder/geocoder.dart';
import 'package:scoops/core/services/location_service.dart';

void main() {
  final service = LocationService();
  group('Location Name Formatting', () {
    test('Valid Address', () {
      var address = Address(subLocality: 'Rahoon', locality: 'Galway');
      var actual = service.formatAddress(address);
      expect(actual, 'Rahoon, Galway');
    });
    test('Null Address', () {
      var actual = service.formatAddress(null);
      expect(actual, "N/A");
    });
    test('Null SubLocality', () {
      var address = Address(subLocality: null, locality: 'Galway');
      var actual = service.formatAddress(address);
      expect(actual, "Galway");
    });
    test('Null Locality', () {
      var address = Address(subLocality: 'Rahoon', locality: null);
      var actual = service.formatAddress(address);
      expect(actual, "Rahoon");
    });
    test('Null Sublocality and Null Locality', () {
      var address =
          Address(subLocality: null, locality: null, countryName: 'Ireland');
      var actual = service.formatAddress(address);
      expect(actual, "Ireland");
    });
    test('Null Sublocality and Null Locality and Null Country', () {
      var address =
          Address(subLocality: null, locality: null, countryName: null);
      var actual = service.formatAddress(address);
      expect(actual, "N/A");
    });
  });
}
