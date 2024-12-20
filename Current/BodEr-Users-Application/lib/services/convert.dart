import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Map<String, dynamic>> convertPointsToListString(List<LatLng> list){
  List<Map<String, dynamic>> route = [];
  for(LatLng point in list){
    route.add(
      {
        'lat': point.latitude,
        'lng': point.longitude,
      }
    );
  }
  return route;
}