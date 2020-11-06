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
    Address first = addresses.first;
    return "${first.subLocality}, ${first.locality}";
  }
}
