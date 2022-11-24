import 'dart:html';

import 'package:geolocator/geolocator.dart';

Future<Position> determinePosition() async {
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
    await Geocoder.local.findAddressesFromCoordinates(coordinate
        + s);
    // print(addresses);
    // currentAddress = addresses.toString();
    var newAddresses = addresses.first;
    // print(newAddresses.toString());

    // print(currentAddress);

    currentAddress = newAddresses.addressLine;
    current_latitude = coordinates.latitude;
    current_longitude = coordinates.longitude;

    _prefs.setString("currentAddress", currentAddress);
    _prefs.setDouble("current_latitude", current_latitude);
    _prefs.setDouble("current_longitude", current_longitude);
  } catch (e) {
    print(e);
  }

  // print("${first.featureName} : ${first.addressLine}");
  // return currentAddress;current_latitude,current_longitude;
}