import 'package:geolocator/geolocator.dart';

class Location {
  double longitude;
  double latitude;

  Future<void> getLocation() async {
    try {
      print("getLocation() called");
      bool isGPSEnabled = await isLocationServiceEnabled();
      bool isPermissionGranted = await isLocationPermissionAccepted();
      if (isGPSEnabled == false || isPermissionGranted == false) return;
      Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.low,
              timeLimit: Duration(seconds: 7))
          .onError((error, stackTrace) {
        print("get location error : " + error.toString());
      });

      latitude = position?.latitude;
      longitude = position?.longitude;
      print("location fetched : ${latitude},$longitude");
    } catch (e) {
      print("get location error : " + e.toString());
    }
  }

  Future<bool> isLocationServiceEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    return true;
  }

  Future<bool> isLocationPermissionAccepted() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    return true;
  }
}
