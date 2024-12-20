import 'dart:async';

import 'package:drivers/views/homepage/homepage_view_model.dart';
import 'package:drivers/widgets/space.dart';
import 'package:drivers/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as loc;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PrecisePickUpScreen extends StatefulWidget {
  const PrecisePickUpScreen({super.key});

  @override
  State<PrecisePickUpScreen> createState() => _PrecisePickUpScreenState();
}

class _PrecisePickUpScreenState extends State<PrecisePickUpScreen> {
  final HomepageViewModel homepageViewModel = Get.put(HomepageViewModel());
  loc.Location location = loc.Location();
  String? address;

  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapController;

  LatLng userCurrentPosition = const LatLng(0, 0);
  LatLng pickupLocation = const LatLng(0, 0);
  double bottomPaddingOfMap = 0;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  locateUserPosition() async {
    Position cPostion = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      userCurrentPosition = LatLng(cPostion.latitude, cPostion.longitude);
      pickupLocation = LatLng(
        userCurrentPosition.latitude + .02,
        userCurrentPosition.longitude + .02
      );
    });
    newGoogleMapController = await _controllerGoogleMap.future;

    LatLng latLngPosition = LatLng(userCurrentPosition.latitude, userCurrentPosition.longitude);
    CameraPosition cameraPosition = CameraPosition(target: latLngPosition, zoom: 15);

    newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> addresses = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      String address = "${addresses[0].street}, ${addresses[0].subLocality}, ${addresses[0].administrativeArea}, ${addresses[0].country}";
      homepageViewModel.setPickupLocation(address);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
   locateUserPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(top: 100, bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller){
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              setState(() {
                bottomPaddingOfMap = 50;
              });

              locateUserPosition();
            },
            markers: {
              Marker(
                markerId: const MarkerId("Place pin to pickup location"),
                position: LatLng(
                  pickupLocation.latitude,
                  pickupLocation.longitude,
                ),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet)
              ),
            },
            onCameraMove: (position){
              setState(() {
                pickupLocation = position.target;
              });
            },
            onCameraIdle: (){
              getAddressFromLatLng(pickupLocation);
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )
                ),
                child: const Text("Set Current Location"),
              ),
            ),
          ),
          Positioned(
            top: verticalSpace(context, .075),
            left: horizontalSpace(context, .0125),
            right: horizontalSpace(context, .0125),
            child: Center(
              child: Container(
                width: horizontalSpace(context, .95),
                color: darkTheme ? Colors.black54 : Colors.white60,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CustomText(
                    text: homepageViewModel.pickupLocation.isEmpty ? "Searching..." : homepageViewModel.pickupLocation, 
                    fontSize: 16, 
                    textColor: darkTheme ? Colors.white : Colors.black,
                  ),
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}
