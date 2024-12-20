import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivers/models/trips_model.dart';
import 'package:drivers/services/printing.dart';
import 'package:get/get.dart';

class PendingTripsViewModel extends GetxController{
  // Observables
  final RxList<TripsModel>  _availableTrips = <TripsModel>[].obs;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? availableTripsStream;

  // Getters
  List<TripsModel> get availableTrips => _availableTrips;

  // Setters
  void setAvailableTrips(List<TripsModel> trips) => _availableTrips.value = trips;

  // Methods
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>> getAvailableTripsStream(){
    return FirebaseFirestore.instance.collection('trips').snapshots().listen(
      (snapshot) {
        List<TripsModel> trips = snapshot.docs.map(
          (data) => TripsModel.fromJSON(data.data())
        ).toList();
        setAvailableTrips(trips);
        Printing.print(availableTrips);
      }
    );
  }

  void initiateAvailableTripsStream(){
    availableTripsStream = getAvailableTripsStream();
  }

  @override
  void onInit() {
    initiateAvailableTripsStream();
    super.onInit();
  }

  @override
  void onClose() {
    availableTripsStream!.cancel();
    super.onClose();
  }
}