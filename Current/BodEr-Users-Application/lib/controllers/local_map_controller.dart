import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_boder/provider/maps_provider.dart';

class LocalMapController extends GetxController{
  MapsProvider mapsProvider = MapsProvider();
  RxList<String> suggestions = <String>[].obs;
  final TextEditingController sourceController = TextEditingController();
  RxString sourceInput = "".obs;

  // Find place autofill suggestions
  Future<void> autofilSuggestions(String input) async {
    suggestions.value = await mapsProvider.findPlaceAutoCompleteSearch(input);
  }
}