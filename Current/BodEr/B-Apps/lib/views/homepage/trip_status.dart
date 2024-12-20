import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivers/views/homepage/homepage_view_model.dart';
import 'package:drivers/views/homepage/main_screen/main_screen.dart';
import 'package:drivers/views/homepage/travel_screen/travel_screen.dart';
import 'package:drivers/widgets/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TripStatus extends StatelessWidget {
  TripStatus({super.key});
  final HomepageViewModel homepageViewModel = Get.find<HomepageViewModel>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: homepageViewModel.tripStatus(),
      builder: (_, snapshot){
        if(snapshot.hasData){
          List data = snapshot.data!.docs.where(
            (doc) => doc['driver'] == FirebaseAuth.instance.currentUser!.email!
          ).toList();
          if(data.isEmpty){
            return MainScreen();
          } else {
            // Printing.print(data.first['pickup_location']);
            // Printing.print(data.first['destination_location']);
            return TravelScreen(
              pickupLocation: data.first['pickup_location'],
              destinationLocation: data.first['destination_location'],
            );
          }
        } else {
          return Center(
            child: Transform.scale(
              scale: 1.5,
              child: CupertinoActivityIndicator(
                color: AppColor.blue,
              ),
            ),
          );
        }
      },
    );
  }
}