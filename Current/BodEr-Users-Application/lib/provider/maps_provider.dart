import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsProvider extends GetConnect{
  Future<List<String>> findPlaceAutoCompleteSearch(String inputText) async {
    try{
    var response = await get("https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&language=en&types=geocode&key=AIzaSyA4piTdQgvmV0PTkKec9NnEK1lMNvW9aaM");
      Map<String, dynamic> data = response.body as Map<String, dynamic>;
      List<String> formated = [];
      for(Map<String, dynamic> single in data["predictions"]){
        formated.add(single["description"]);
      }
      return formated;
    } catch(e){
      return <String>[];
    }
  }

  Future<List<LatLng>> getPolylinePoints(String inputText, String destinationText) async {
    try{
      List<LatLng> formated = <LatLng>[];
      var response = await get("https://maps.googleapis.com/maps/api/directions/json?destination=$destinationText&origin=$inputText&key=AIzaSyA4piTdQgvmV0PTkKec9NnEK1lMNvW9aaM");
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
}