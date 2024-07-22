import 'package:bodae/Maps/map_controller.dart';
import 'package:bodae/widgets/space.dart';
import 'package:bodae/widgets/spacing.dart';
import 'package:bodae/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key, required this.localMapController});
  final LocalMapController localMapController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Opacity(
            opacity: localMapController.loading.value ? .55 : 1,
            child: GoogleMap(
              onMapCreated: (controller){
                if(!localMapController.controller.isCompleted){  w ms 
                  localMapController.controller.complete(controller);
                }
              },
              initialCameraPosition: CameraPosition(
                target: localMapController.currentLocation.value,
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("Current position"),
                  infoWindow: const InfoWindow(
                    title: "Current position"
                  ),
                  position: localMapController.currentLocation.value,
                ),
              },
            ),
          ),
          Visibility(
            visible: localMapController.loading.value,
            child: AlertDialog(
              content: Padding(
                padding: EdgeInsets.only(
                  top: verticalSpace(context, .03),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(
                      color: Colors.pink,
                    ),
                    CustomSpacing(height: .02),
                    CustomText(
                      text: "Please wait...", 
                      fontSize: 14, 
                      textColor: Colors.grey.shade600,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}