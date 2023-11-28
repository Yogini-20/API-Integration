import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard_view.dart';

class DashboardController extends GetxController {

  int currentTab = 0;
  final List screens = [const DashboardView()];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const DashboardView();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  RxString address = 'search'.obs;
  RxString names=''.obs;
  RxString organisationName=''.obs;
  RxString emailId=''.obs;
  RxString phone=''.obs;
  RxString action=''.obs;
  RxString id=''.obs;
  RxString currentDate=''.obs;
  RxBool trigger=true.obs;

  Future<void> logoutGoogle() async {
    await googleSignIn.signOut();
  }



  getCurrentDate() {
    var date = DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    currentDate.value = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    }


  getPosition() async {
    Position position = await getGeoLocationPosition();
    getAddressFromLatLong(position);
  }

  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    if (kDebugMode) {
      print(placemarks);
    }
    Placemark place = placemarks[0];
    address.value= '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    }

  RxString email = ''.obs;
  @override
  Future<void> onInit() async {
    await getPosition();
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // trigger.value = prefs.getBool('trigger')!;
  }



}
