import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:map_picker/map_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../controller/settings/profileInfoController.dart';
import '../../base/custom_button.dart';
import 'common_location_controller.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({Key? key}) : super(key: key);

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();
  CommonLocationController _commonLocationController =
      Get.put(CommonLocationController());
  ProfileInfoController _profileInfoController =
      Get.put(ProfileInfoController());




  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(41.311158, 69.279737),
    zoom: 14.4746,
  );

  var userToken;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();

    userToken= Get.parameters['userToken'];
  }

  Future<void> _getCurrentLocation() async {
    // Request location permission
    final status = await Permission.location.request();

    if (status.isGranted) {
      try {
        // Check if location services are enabled
        bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          // Show dialog to enable location services
          if (mounted) {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Location Services Disabled'),
                content: const Text(
                    'Please enable location services to use this feature.'),
                actions: [
                  TextButton(
                    child: const Text('Open Settings'),
                    onPressed: () {
                      Geolocator.openLocationSettings();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          }
          return;
        }

        // Get current position
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        // Update camera position
        final newPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14.4746,
        );

        if (mounted) {
          setState(() {
            cameraPosition = newPosition;
          });
        }

        // Move camera to current location
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(newPosition));

        // Get address for current location
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (mounted) {
          setState(() {
            // _commonLocationController.locationNameController.text = '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error getting location: $e')),
          );
        }
      }
    } else {
      if (mounted) {
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission denied')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          MapPicker(
            iconWidget: SvgPicture.asset(
              "assets/images/markerIcon.svg",
              height: 60,
            ),
            mapPickerController: mapPickerController,
            child: GoogleMap(
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onCameraMoveStarted: () {
                mapPickerController.mapMoving!();
                _commonLocationController.locationNameController
                  ..text = "checking ...";
              },
              onCameraMove: (cameraPosition) {
                this.cameraPosition = cameraPosition;
              },
              onCameraIdle: () async {
                mapPickerController.mapFinishedMoving!();
                List<Placemark> placemarks = await placemarkFromCoordinates(
                  cameraPosition.target.latitude,
                  cameraPosition.target.longitude,
                );
                _commonLocationController.locationNameController
                  ..text =
                      ' ${placemarks.first.street},${placemarks.first.locality}, ${placemarks.first.subLocality}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).viewPadding.top + 20,
            width: MediaQuery.of(context).size.width - 50,
            height: 60,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextFormField(
                maxLines: 3,
                textAlign: TextAlign.center,
                readOnly: true,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  border: InputBorder.none,
                ),
                controller: _commonLocationController.locationNameController,
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: SizedBox(
              height: 50,
              child:
    Obx(
    () =>CustomButton(
        loading: _commonLocationController.setLocationLoading.value,
        onTap: () {
          print(
              "Location ${cameraPosition.target.latitude} ${cameraPosition.target.longitude}");
          print(
              "Address: ${_commonLocationController.locationNameController.text}");
          _commonLocationController.latitude.value =
              cameraPosition.target.latitude.toString();
          _commonLocationController.longitude.value =
              cameraPosition.target.longitude.toString();

          //set location to update profile
          _profileInfoController.locationName.value =
              _commonLocationController.locationNameController.text;
          _profileInfoController.latitude.value =cameraPosition.target.latitude.toString();
          _profileInfoController.longitude.value =cameraPosition.target.longitude.toString();


          _profileInfoController.updateProfileLocation(userToken);


          // _commonLocationController.setLocation(
          //     latitude: cameraPosition.target.latitude.toString(),
          //     longitude: cameraPosition.target.longitude.toString());
        },
        text: "Submit"),),

            ),
          )
        ],
      ),
    );
  }
}
