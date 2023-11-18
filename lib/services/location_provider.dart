import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wheather_app/services/location_service.dart';

class LocationProvider extends ChangeNotifier {
  Position? currentposition;
  final LocationService locationService = LocationService();
  Placemark? currentLocationName;

  Future positionFinder() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      currentposition = null;
      notifyListeners();
      return;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        currentposition = null;
        notifyListeners();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      currentposition = null;
      notifyListeners();
      return;
    }

    currentposition = await Geolocator.getCurrentPosition();
    print(currentposition);

    currentLocationName =
        await locationService.getLocationName(currentposition);
    print(currentLocationName);
    notifyListeners();
  }
}
