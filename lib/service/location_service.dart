import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController {
  Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  Rx<Marker?> marker = Rx<Marker?>(null);

  // Fetch current location
  Future<void> fetchCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      currentLocation.value = LatLng(position.latitude, position.longitude);

      // Update marker
      marker.value = Marker(
        markerId: const MarkerId('currentLocation'),
        position: currentLocation.value!,
        infoWindow: const InfoWindow(title: "You are here"),
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Update location manually
  void updateLocation(LatLng location) {
    currentLocation.value = location;
    marker.value = Marker(
      markerId: const MarkerId('userLocation'),
      position: location,
      infoWindow: const InfoWindow(title: "User location"),
    );
  }
}
