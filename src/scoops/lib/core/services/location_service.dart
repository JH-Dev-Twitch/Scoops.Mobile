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
    if (address.subLocality == null) {
      return address.locality;
    }
    var fullLocation = "${address.subLocality}, ${address.locality}";
    var maxLength = 30;
    return fullLocation.length < maxLength ? fullLocation : address.locality;
  }
}
