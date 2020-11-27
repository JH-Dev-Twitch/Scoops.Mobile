import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<String> getLocation() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    var position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    return addresses.isNotEmpty ? formatAddress(addresses.first) : "N/A";
  }

  String formatAddress(Address address) {
    int maxLength = 30;
    if (address == null) return "N/A";
    if (address.locality == null && address.subLocality == null)
      return address.countryName ?? 'N/A';
    if (address.subLocality == null || address.locality == null)
      return address.subLocality == null
          ? address.locality
          : address.subLocality;
    if (address.subLocality != null && address.locality != null) {
      var fullLocation = "${address.subLocality}, ${address.locality}";
      return fullLocation.length < maxLength ? fullLocation : address.locality;
    }
    return "N/A";
  }
}
