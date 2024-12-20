// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class MapsHomeScreen extends StatefulWidget {
  const MapsHomeScreen({super.key});

  @override
  State<MapsHomeScreen> createState() => _MapsHomeScreenState();
}

class _MapsHomeScreenState extends State<MapsHomeScreen> {

  LatLng? picklocation;
  loc.Location location = loc.Location();
  String? _address;

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  double searchLocationContainerHeight = 200;
  double waitingResponseFromDriverContainerHeight= 0;
  double  assignDriverInfoContainerHeight = 0;

  Position? userCurrentPosition;
  var geolocation = Geolocator();
  LocationPermission?  _locationPermission;

  double bottomPaddingOfMap = 0;
  
  List<LatLng> pLineCoordinatToList = [];
  Set<Polyline> polylineSet = {};

  Set<Marker> makerSet = {};
  Set<Circle> circleSet = {};

  String userName = '';
  String userEmail = "";

  bool openNavigatorDrawer= true;
  bool activeNearbyDriverkeysLoaded = true;

   BitmapDescriptor? activeNearbyIcon;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}