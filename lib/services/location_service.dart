import 'package:flutter/rendering.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future getLocationName(Position? position) async {
    if (position != null) {
      try {
        final placemark = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        if (placemark.isNotEmpty) {
          return placemark[0];
        }
      } catch (e) {
        print('error fetching location');
      }
      return null;
    }
  }
}
