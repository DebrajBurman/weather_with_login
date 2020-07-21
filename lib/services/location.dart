import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class Location {
  double latitude;
  double longitude;

  Future<void> getLocation() async {
    bool isLocationEnabled = await Geolocator().isLocationServiceEnabled();
    print(isLocationEnabled);
    if (isLocationEnabled == false) {
      Fluttertoast.showToast(
        msg: 'Please Turn on Location!',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white,
      );
    }
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
