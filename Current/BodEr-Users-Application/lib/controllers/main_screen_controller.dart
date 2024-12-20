import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as lc;
import 'package:user_boder/global/map_key.dart';
import 'package:user_boder/provider/maps_provider.dart';
import 'package:user_boder/services/convert.dart';

class MainScreenController extends GetxController{
  MapsProvider mapsProvider = MapsProvider();
  RxString pickupLocation = "".obs;
  RxString destinationLocation = "".obs;
  RxList<LatLng> allPolylinePoints = <LatLng>[].obs;
  PolylinePoints polylinePoints = PolylinePoints();
  RxBool checkPrice = false.obs;
  RxBool loading = false.obs;
  RxDouble price = 0.0.obs;
  RxDouble rating = 0.0.obs;
  RxInt play = 0.obs;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Rx<CameraPosition> initialCameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  ).obs;

  // Find Polyline points (source to destination) []
  Future<void> polylinePointDirections() async {
    loading.value = true;
    try{
      PointLatLng start = await locationFromAddress(pickupLocation.value).then(
        (location) => PointLatLng(location.first.latitude, location.first.longitude),
      );
      PointLatLng end = await locationFromAddress(destinationLocation.value).then(
        (location) => PointLatLng(location.first.latitude, location.first.longitude),
      );
      PolylineResult polylineResult = await polylinePoints.getRouteBetweenCoordinates(
        request: PolylineRequest(
          origin: start, 
          destination: end,
          mode: TravelMode.driving,
        ),
        googleApiKey: mapKey,
      );
      allPolylinePoints.clear();
      price.value = .05 * (polylineResult.totalDistanceValue ?? 1);
      for(PointLatLng point in polylineResult.points){
        allPolylinePoints.add(
          LatLng(point.latitude, point.longitude),
        );
      }
      loading.value = false;
    } catch(e) {
      loading.value = false;
      Get.snackbar(
        "Error!!!",
        e.toString(),
      );
    }
  }

  Future<void> triggerRebuils() async {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await Future.delayed(const Duration(seconds: 1), (){
        play.value += 1;
      });
      await Future.delayed(const Duration(seconds: 1), (){
        play.value -= 1;
      });
    });
  }

  Future<void> requestTrip() async {
    loading.value = true;
    try{
      await firebaseFirestore.collection('trips').doc(firebaseAuth.currentUser!.email).set(
        {
          "pickup_location": pickupLocation.value,
          "destination_location": destinationLocation.value,
          'driver_accepted': false,
          'driver_arrive': false,
          'trip_ended': false,
          'route': allPolylinePoints.toStringList,
          'price': price.value,
          'user': firebaseAuth.currentUser!.email,
          'driver': null,
        }
      );
      checkPrice.value = false;
      loading.value = false;
    } catch(e){
    loading.value = false;
      Get.snackbar(
        "Error!!!",
        e.toString(),
      );
    }
  }

  Future<void> cancelRequest() async {
    loading.value = true;
    try{
      await firebaseFirestore.collection('trips').doc(firebaseAuth.currentUser!.email).delete();
      checkPrice.value = false;
      loading.value = false;
    } catch(e){
      loading.value = false;
      Get.snackbar(
        "Error!!!",
        e.toString(),
      );
    }
  }

  Stream<Map<String, dynamic>> tripStatus(){
    return firebaseFirestore.collection('trips').doc(firebaseAuth.currentUser!.email).get().then(
      (data) {
        Map<String, dynamic>? trip = data.data();
        return trip ?? <String, dynamic>{};
      }
    ).asStream();
  }

  Future<void> checkPermission() async {
    lc.Location location = lc.Location();
    lc.PermissionStatus permissionStatus = await location.hasPermission();
    bool enabled = await location.serviceEnabled();
    if(!enabled){
      await location.requestService();
      checkPermission();
    } else {
      if(permissionStatus == lc.PermissionStatus.granted || permissionStatus == lc.PermissionStatus.grantedLimited){
        return;
      } else {
        await location.requestPermission();
        checkPermission();
      }
    }
  }

  @override
  void onInit() {
    checkPermission();
    triggerRebuils();
    super.onInit();
  }
}

extension on List<LatLng>{
  List<Map<String, dynamic>> get toStringList => convertPointsToListString(this);
}