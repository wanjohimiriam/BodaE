import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocalMapController extends GetxController{
  final Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  Rx<LatLng> currentLocation = const LatLng(0, 0).obs;
  RxList<LatLng> allPolylinePoints = <LatLng>[].obs;
  RxList<LatLng> nearbyPlaces = <LatLng>[].obs;
  RxList<Map> searchResults = <Map>[].obs;
  RxString type = "church".obs;
  RxInt radius = 100.obs;
  RxBool loading = false.obs;
  RxMap details = {}.obs;
  Location location = Location();

  void initialLocation() async {
    LocationData position = await location.getLocation();
    currentLocation.value = LatLng(position.latitude!, position.longitude!);
    location.onLocationChanged.listen(
      (event) {
        currentLocation.value = LatLng(event.latitude!, event.longitude!);
      }
    );
    moveCamera();
  }

  Future<void> moveCamera() async {
    final GoogleMapController newController = await controller.future;
    newController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: currentLocation.value,
          zoom: 15,
        ),
      ),
    );
  }

  // Future<void> getPolylinePoints(double latitude, double longitude, TravelMode travelMode) async {
  //   loading.value = true;
  //   try{
  //     PolylinePoints polylinePoints = PolylinePoints();
  //     PolylineResult polylineResult = await polylinePoints.getRouteBetweenCoordinates(
  //       request: PolylineRequest(
  //         origin: PointLatLng(
  //           currentLocation.value.latitude,
  //           currentLocation.value.longitude,
  //         ), 
  //         destination: PointLatLng(
  //           latitude,
  //           longitude,
  //         ),
  //         mode: travelMode,
  //       ),
  //       googleApiKey: "",
  //     );
  //     allPolylinePoints.clear();

  //     for (var point in polylineResult.points) {
  //       allPolylinePoints.add(
  //         LatLng(point.latitude, point.longitude),
  //       );
  //     }
  //     loading.value = false;
  //   } catch(e) {
  //     Get.snackbar(
  //       "Error!!!",
  //       e.toString(),
  //     );
  //   }
  // }

  @override
  void onInit() {
    initialLocation();
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (callback) => descriptionDialog()
    // );
    super.onInit();
  }
}