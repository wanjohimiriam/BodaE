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

List<LatLng> convertListStringToPoints(List<Map<String, dynamic>> list){
  List<LatLng> route = [];
  for(Map<String, dynamic> point in list){
    route.add(
      LatLng(
        point['lat'],
        point['lng']
      ),
    );
  }
  return route;
}