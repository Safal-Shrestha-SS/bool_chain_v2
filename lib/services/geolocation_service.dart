import 'package:geolocator/geolocator.dart';

class GeoLocationService {
  Future<Position> getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  Future<String> getAddress(Position position) async {
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    return placemark.toString();
  }

  Future<double> distanceBetweenCoordintaes(Position A, Position B) async {
    double distanceInMeters = await Geolocator()
        .distanceBetween(A.latitude, A.longitude, B.latitude, B.longitude);
    return distanceInMeters;
  }
}
