import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user_boder/services/convert.dart';

extension on List<LatLng>{
  List<Map<String, dynamic>> get toStringList => convertPointsToListString(this);
}