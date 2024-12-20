import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class TravelScreenViewModel extends GetxController{
  final Location location = Location();
  // Observables
  final Rx<LatLng> _cameraPosition = LatLng(0, 0).obs;
  final Rx<LatLng> _driverPosition = LatLng(0, 0).obs;
  final RxMap<String, dynamic> _tripStatus = <String, dynamic>{}.obs;

  // Getters
  LatLng get cameraPosition => _cameraPosition.value;
  LatLng get driverPosition => _driverPosition.value;
  Map<String, dynamic> get tripStatus => _tripStatus;

  // Setters
  void setCameraPosition(LatLng value) => _cameraPosition.value = value;
  void setDriverPosition(LatLng value) => _driverPosition.value = value;

  Future<void> getCurrentLocation() async {
    LocationData position = await location.getLocation();
    _cameraPosition.value = LatLng(
      position.latitude!,
      position.longitude! 
    );
    location.onLocationChanged.listen(
      (position){
        _cameraPosition.value = LatLng(
          position.latitude!,
          position.longitude! 
        );
      }
    );
  }

  checkTripStatus(){
    return FirebaseFirestore.instance.collection('trips').doc(FirebaseAuth.instance.currentUser!.email).get().then(
      (data) {
        Map<String, dynamic>? trip = data.data();
        return trip ?? <String, dynamic>{};
      }
    ).asStream().listen(
      (data) {
        _tripStatus.value = data;
      }
    );
  }

  @override
  void onInit() {
    getCurrentLocation();
    checkTripStatus();
    super.onInit();
  }
}