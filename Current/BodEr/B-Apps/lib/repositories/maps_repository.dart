import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MapsRepository extends GetConnect{
  String apiKey = dotenv.env['MAP_KEY'] ?? '';
  Future<List<LatLng>> getPolylinePoints(String inputText, String destinationText) async {
    try{
      List<LatLng> formated = <LatLng>[];
      var response = await get("https://maps.googleapis.com/maps/api/directions/json?destination=$destinationText&origin=$inputText&key=$apiKey");
      Map<String, dynamic> data = response.body as Map<String, dynamic>;
      for(Map<String, dynamic> single in data["routes"][0]['legs'][0]['steps']){
        formated.addAll(
          [
            LatLng(
              single["start_location"]['lat'],
              single["start_location"]['lng']
            ),
            LatLng(
              single["end_location"]['lat'],
              single["end_location"]['lng']
            ),
          ]
        );
      }
      return formated;
    } catch(e){
      return <LatLng>[];
    }
  }

  Future<String> getAddress(LatLng point) async {
    List<Placemark> output = await GeocodingPlatform.instance!.placemarkFromCoordinates(point.latitude, point.longitude);
    return "${output.first.name}, ${output.first.locality}, ${output.first.administrativeArea}, ${output.first.country}";
  }
}