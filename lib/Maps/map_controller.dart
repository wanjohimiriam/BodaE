import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocalMapController extends GetxController {
  final Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  Rx<LatLng> currentLocation = const LatLng(0, 0).obs;
  RxList<LatLng> allPolylinePoints = <LatLng>[].obs;
  RxList<Map> searchResults = <Map>[].obs;
  RxList<LatLng> riders = <LatLng>[].obs;
  RxString type = "church".obs;
  RxInt radius = 100.obs;
  RxBool loading = false.obs;
  RxMap details = {}.obs;
  Rx<LatLng?> requestedRider = Rx<LatLng?>(null);
  RxString destination = "".obs;
  RxBool rideAccepted = false.obs;
  Location location = Location();

  final List<Map<String, dynamic>> staticRiders = [
    {
      'location': LatLng(-1.286389, 36.817223), // Nairobi CBD
      'address': 'Nairobi CBD'
    },
    {
      'location': LatLng(-1.2921, 36.8219), // Nairobi
      'address': 'Nairobi'
    },
    {
      'location': LatLng(-1.295833, 36.825), // Westlands
      'address': 'Westlands, Nairobi'
    },
    {
      'location': LatLng(-1.299167, 36.821944), // Kilimani
      'address': 'Kilimani, Nairobi'
    },
  ];

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

  void requestRide(LatLng riderLocation) {
    requestedRider.value = riderLocation;
  }

  void acceptRide() {
    rideAccepted.value = true;
  }

  List<Map<String, dynamic>> getCloseRiders() {
    return staticRiders.take(4).toList();
  }

  @override
  void onInit() {
    initialLocation();
    super.onInit();
  }
}



// import 'dart:async';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// class LocalMapController extends GetxController {
//   final Completer<GoogleMapController> controller = Completer<GoogleMapController>();
//   Rx<LatLng> currentLocation = const LatLng(0, 0).obs;
//   RxList<LatLng> allPolylinePoints = <LatLng>[].obs;
//   RxList<LatLng> nearbyPlaces = <LatLng>[].obs;
//   RxList<Map> searchResults = <Map>[].obs;
//   RxList<LatLng> riders = <LatLng>[].obs;
//   RxString type = "church".obs;
//   RxInt radius = 100.obs;
//   RxBool loading = false.obs;
//   RxMap details = {}.obs;
//   Location location = Location();

//   void initialLocation() async {
//     LocationData position = await location.getLocation();
//     currentLocation.value = LatLng(position.latitude!, position.longitude!);
//     location.onLocationChanged.listen(
//       (event) {
//         currentLocation.value = LatLng(event.latitude!, event.longitude!);
//       }
//     );
//     moveCamera();
//   }

//   Future<void> moveCamera() async {
//     final GoogleMapController newController = await controller.future;
//     newController.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: currentLocation.value,
//           zoom: 15,
//         ),
//       ),
//     );
//   }

//   void addRiderLocation(LatLng location) {
//     riders.add(location);
//   }

//   @override
//   void onInit() {
//     initialLocation();
//     super.onInit();
//   }
// }
