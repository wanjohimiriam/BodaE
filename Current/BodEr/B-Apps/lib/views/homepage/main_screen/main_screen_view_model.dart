import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class MainScreenViewModel extends GetxController{
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  final TextEditingController destinationLocation = TextEditingController();
  final TextEditingController pickupLocation = TextEditingController();
  final FocusNode mapFocus = FocusNode();
  final FocusNode formFocus = FocusNode();
  final DraggableScrollableController draggableScrollableController = DraggableScrollableController();

  // Observables
  final Rx<BitmapDescriptor> _tripMarker = BitmapDescriptor.defaultMarker.obs;
  final Rx<BitmapDescriptor> _personMarker = BitmapDescriptor.defaultMarker.obs;
  final Rx<BitmapDescriptor> _sourceMarker = BitmapDescriptor.defaultMarker.obs;
  final Rx<BitmapDescriptor> _destinationMarker = BitmapDescriptor.defaultMarker.obs;
  final Rx<BitmapDescriptor> _meetingMarker = BitmapDescriptor.defaultMarker.obs;
  final RxBool _visible = false.obs;
  final RxString _pickupAddress = ''.obs;
  final RxString _destinationAddress = ''.obs;

  // Getters
  BitmapDescriptor get tripMarker => _tripMarker.value;
  BitmapDescriptor get personMarker => _personMarker.value;
  BitmapDescriptor get sourceMarker => _sourceMarker.value;
  BitmapDescriptor get destinationMarker => _destinationMarker.value;
  BitmapDescriptor get meetingMarker => _meetingMarker.value;
  bool get visible => _visible.value;
  String get pickupAddress => _pickupAddress.value;
  String get destinationAddress => _pickupAddress.value;

  // Setters
  void setVisible(bool value) => _visible.value = value;
  void setPickupAddress(String value) => _pickupAddress.value = value;
  void setDestinationAddress(String value) => _destinationAddress.value = value;

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
  
  void createIcons() async {
    final Uint8List tripIcon = await getBytesFromAsset('assets/icons/trips.png', 80);
    final Uint8List personIcon = await getBytesFromAsset('assets/icons/person.png', 100);
    final Uint8List destinationIcon = await getBytesFromAsset('assets/icons/destination.png', 100);
    final Uint8List meetingIcon = await getBytesFromAsset('assets/icons/meet_icon.png', 100);
    final Uint8List sourceIcon = await getBytesFromAsset('assets/icons/source.png', 100);
    _tripMarker.value = BitmapDescriptor.bytes(tripIcon);
    _personMarker.value = BitmapDescriptor.bytes(personIcon);
    _sourceMarker.value = BitmapDescriptor.bytes(sourceIcon);
    _destinationMarker.value = BitmapDescriptor.bytes(destinationIcon);
    _meetingMarker.value = BitmapDescriptor.bytes(meetingIcon);
  }
}