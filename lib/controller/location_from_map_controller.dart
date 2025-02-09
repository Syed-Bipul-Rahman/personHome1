import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../helpers/prefs_helpers.dart';
import '../helpers/route.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import '../utils/app_constants.dart';

class LocationFromMapController extends GetxController {
  var selectedLocation = Rxn<LatLng>(); // Store selected location
  var marker = Rxn<Marker>(); // Store the marker
  var currentLocation = Rxn<LatLng>(); // Store the current location of the user
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  // Fetch current location
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      // currentLocation.value = LatLng(position.latitude, position.longitude);

      currentLocation.value = LatLng(44.968046, -94.420307);
      updateMarker(currentLocation.value!);
    } catch (e) {
      Get.snackbar("nice", "Failed to get current location: $e",duration: Duration(seconds: 3));

    }
  }

  // Update marker location
  void updateLocation(LatLng location) {
    selectedLocation.value = location;
    updateMarker(location);
  }

  // Update the marker's position
  void updateMarker(LatLng location) {
    marker.value = Marker(
      markerId: MarkerId('selectedLocation'),
      position: location,
      infoWindow: InfoWindow(title: 'Selected Location'),
    );
  }

  // Toggle loading state
  void changeLoading(bool value) {
    isLoading.value = value;
  }
}
