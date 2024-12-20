// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:drivers/repositories/maps_repository.dart';
import 'package:drivers/services/permissions/location_permission.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as lc;

class HomepageViewModel extends GetxController{
  MapsRepository mapsRepository = MapsRepository();
  final Completer<GoogleMapController> _completer = Completer<GoogleMapController>();
  PolylinePoints polylinePoints = PolylinePoints();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  lc.Location location = lc.Location();
  StreamSubscription<lc.LocationData>? locationStream;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? pendingTripStream;

  // Observables
  final RxString _pickupLocation = "".obs;
  final RxString _destinationLocation = "".obs;
  final RxList<LatLng> _allPolylinePoints = <LatLng>[].obs;
  final RxBool _checkPrice = false.obs;
  final RxBool _loading = false.obs;
  final RxDouble _price = 0.0.obs;
  final RxDouble _rating = 0.0.obs;
  final RxInt _play = 0.obs;
  final Rx<CameraPosition> _initialCameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  ).obs;
  final Rx<LatLng> _currentLocation = const LatLng(37.42796133580664, -122.085749655962).obs;
  final Rx<LatLng> _dropPinLocation = const LatLng(37.42796133580664, -122.085749655962).obs;
  final RxString _styleString = ''.obs;
  final RxBool _pinVisibility = false.obs;
  final RxDouble _zoom = 10.0.obs;
  final RxList<LatLng> _availableDrivers = <LatLng>[].obs;
  final RxBool _pickupSet = false.obs;
  final RxBool _hasPending = false.obs;

  // Getters
  String get pickupLocation => _pickupLocation.value;
  String get destinationLocation => _destinationLocation.value;
  List<LatLng> get allPolylinePoints => _allPolylinePoints.value;
  bool get checkPrice => _checkPrice.value;
  bool get loading => _loading.value;
  double get price => _price.value;
  double get rating => _rating.value;
  int get play => _play.value;
  CameraPosition get initialCameraPosition => _initialCameraPosition.value;
  LatLng get currentLocation => _currentLocation.value;
  Completer<GoogleMapController> get completer => _completer;
  String get styleString => _styleString.value;
  bool get pinVisibility => _pinVisibility.value;
  LatLng get dropPinLocation => _dropPinLocation.value;
  double get zoom => _zoom.value;
  List<LatLng> get availableDrivers => _availableDrivers.value;
  bool get pickupSet => _pickupSet.value;
  bool get hasPending => _hasPending.value;

  // Setters
  void setPickupLocation(String value) => _pickupLocation.value = value;
  void setDestinationLocation(String value) => _destinationLocation.value = value;
  void setAllPolylinePoints(List<LatLng> value) => _allPolylinePoints.value = value;
  void setCheckPrice(bool value) => _checkPrice.value = value;
  void setLoading(bool value) => _loading.value = value;
  void setPrice(double value) => _price.value = value;
  void setRating(double value) => _rating.value = value;
  void setPlay(int value) => _play.value = value;
  void setInitialCameraPosition(CameraPosition value) => _initialCameraPosition.value = value;
  void setCurrentLocation(LatLng value) => _currentLocation.value = value;
  void setDropPinLocation(LatLng value) {
    _dropPinLocation.value = value;
    getAddressFromPoint(dropPinLocation);
  }
  void setZoom(double value) => _zoom.value = value;
  void setAvailableDrivers(List<LatLng> latlng) => _availableDrivers.value = latlng;
  void setPickupSet(bool value) => _pickupSet.value = value;
  void setHasPending(bool value) => _hasPending.value = value;

  void togglePinVisibility() {
    _pinVisibility.value = !pinVisibility;
  }
  
  Future<void> getCurrentLocation() async {
    await checkPermission();
    lc.LocationData position = await location.getLocation();
    LatLng myPosition = LatLng(position.latitude!, position.longitude!);
    setCurrentLocation(myPosition);
    setDropPinLocation(LatLng(myPosition.latitude + 0.001, myPosition.longitude));
    setZoom(15);
    animateToPosition(myPosition);
  }

  // Animate to position
  Future<void> animateToPosition(LatLng latlng) async {
    GoogleMapController googleMapController = await _completer.future;
    await googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latlng,
          zoom: zoom,
        ),
      ),
    );
  }

  Future<void> loadStyling() async {
    await rootBundle.loadString('assets/light_theme.json').then((string) {
      _styleString.value = string;
    });
  }

  Future<void> getAddressFromPoint(LatLng point) async {
    String markers = await mapsRepository.getAddress(point);
    _pickupLocation.value = markers;
  }

  // Find Polyline points (source to destination) []
  Future<void> polylinePointFromAdress(String sourceLocation, String destinationLocation) async {
    _loading.value = true;
    try{
      PointLatLng source = await locationFromAddress(sourceLocation).then(
        (value) => PointLatLng(value.first.latitude, value.first.longitude),
      );
      PointLatLng destination = await locationFromAddress(destinationLocation).then(
        (value) => PointLatLng(value.first.latitude, value.first.longitude),
      );
      PolylineResult polylineResult = await polylinePoints.getRouteBetweenCoordinates(
        request: PolylineRequest(
          origin: source,
          destination: destination,
          mode: TravelMode.driving,
        ),
        googleApiKey: dotenv.env['MAP_KEY'],
      );
      allPolylinePoints.clear();
      _price.value = .035 * (polylineResult.totalDistanceValue ?? 1);
      for(PointLatLng point in polylineResult.points){
        allPolylinePoints.add(
          LatLng(point.latitude, point.longitude),
        );
      }
      setZoom(15);
      _loading.value = false;
      animateToPosition(allPolylinePoints.first);
    } catch(e) {
      _loading.value = false;
      Get.snackbar(
        "Error!!!",
        e.toString(),
      );
    }
  }

  Future<void> acceptTrip(String id) async {
    _loading.value = true;
    try{
      Map<String, dynamic>? data = await firebaseFirestore.collection('trips').doc(id).get().then(
        (value) => value.data()
      );
      if(data != null){
        data['driver'] = FirebaseAuth.instance.currentUser!.email!;
        data['driver_accepted'] = true;
        await firebaseFirestore.collection('trips').doc(id).update(data);
      }
      _checkPrice.value = false;
      _loading.value = false;
      Get.offNamed('/mainScreen');
    } catch(e){
      _loading.value = false;
      Get.snackbar(
        "Error!!!",
        e.toString(),
      );
    }
  }

  Future<void> cancelTrip() async {
    _loading.value = true;
    try{
      await firebaseFirestore.collection('trips').doc(firebaseAuth.currentUser!.email).delete();
      allPolylinePoints.clear();
      _checkPrice.value = false;
      _loading.value = false;
      Get.offNamed('/mainScreen');
    } catch(e){
      _loading.value = false;
      Get.snackbar(
        "Error!!!",
        e.toString(),
      );
    }
  }

  StreamSubscription<lc.LocationData> streamMyPosition(){
    return location.onLocationChanged.listen((latlng) async {
      Map<String, dynamic>? data = await firebaseFirestore.collection('drivers').doc(
        FirebaseAuth.instance.currentUser!.email,
      ).get().then((value) => value.data());
      if(data != null){
        data['location']['lat'] = latlng.latitude ?? data['location']['lat'];
        data['location']['long'] = latlng.longitude ?? data['location']['long'];
        await firebaseFirestore.collection('drivers').doc(
          FirebaseAuth.instance.currentUser!.email,
        ).update(data); 
      }
    });
  }

  initiateStream(){
    locationStream = streamMyPosition();
  }

  Future<void> finishTrip() async {
    _loading.value = true;
    try{
      Map<String, dynamic>? data = await firebaseFirestore.collection('trips').doc(FirebaseAuth.instance.currentUser!.email).get().then(
        (value) => value.data() ?? <String, dynamic>{},
      );
      if(data != null){
        data['trip_ended'] = true;
        await firebaseFirestore.collection('trips').doc(FirebaseAuth.instance.currentUser!.email).update(data);
        allPolylinePoints.clear();
      }
      _checkPrice.value = false;
      _loading.value = false; 
    } catch(e){
      _loading.value = false;
      Get.snackbar(
        "Error!!!",
        e.toString(),
      );
    }
  }

  Future<void> confirmPayment() async {
    _loading.value = true;
    try{
      
      _checkPrice.value = false;
      _loading.value = false;
    } catch(e){
      _loading.value = false;
      Get.snackbar(
        "Error!!!",
        e.toString(),
      );
    }
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> availableTrips(){
    return firebaseFirestore.collection('trips').snapshots().listen(
      (response) async {
        int count = response.docs.where(
          (doc) => doc['driver'] == FirebaseAuth.instance.currentUser!.email,
        ).toList().length;
        setHasPending(count == 0);
      }
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> tripStatus(){
    return firebaseFirestore.collection('trips').snapshots();
  }

  initiateAvailableTrips(){
    pendingTripStream = availableTrips();
  }

  @override
  void onInit() {
    getCurrentLocation();
    initiateStream();
    initiateAvailableTrips();
    super.onInit();
  }

  @override
  void onClose() {
    locationStream!.cancel();
    pendingTripStream!.cancel();
    super.onClose();
  }
}