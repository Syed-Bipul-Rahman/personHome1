import 'package:geocoding/geocoding.dart';
class LocationHelper{
 static getLocationName(double latitude, double longitude) async {
    try {
      // Fetch the placemark for the given coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        // Construct a human-readable address
        String locationName = "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        return locationName;
      } else {
        return "Location name not found";
      }
    } catch (e) {
      // Handle errors, such as invalid coordinates or permissions not granted
      print("Error: $e");
      return "Error occurred while fetching location";
    }
  }
}