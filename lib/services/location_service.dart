import 'dart:html';

import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

determinePosition() async {
  bool serviceEnabled;

  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    permission = await Geolocator.requestPermission();

    print(serviceEnabled);
    return Future.error('Location services are disabled.');
  }

  // permission = await Geolocator.requestPermission();
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permantly denied, we cannot request permissions.');
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return Future.error(
          'Location permissions are denied (actual value: $permission).');
    }
  }
}

Future getLocation() async {
  try {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // debugPrint('location: ${position.latitude}');
    final coordinates =
    Coordinates(position.latitude, position.longitude);
    var addresses =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    // print(addresses);
    // currentAddress = addresses.toString();
    var newAddresses = addresses.first;
    // print(newAddresses.toString());
  } catch (e) {
    print(e);
  }

  // print("${first.featureName} : ${first.addressLine}");
  // return currentAddress;current_latitude,current_longitude;
}