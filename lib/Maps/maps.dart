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
                if(!localMapController.controller.isCompleted){
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
// import 'package:bodae/Constants/colors.dart';
// import 'package:bodae/widgets/space.dart';
// import 'package:bodae/widgets/spacing.dart';
// import 'package:bodae/widgets/text.dart';
// import 'package:bodae/widgets/textfields.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'map_controller.dart';

// class MapPage extends StatelessWidget {
//   final LocalMapController localMapController;

//   MapPage({super.key, required this.localMapController});

//   double? _devWidth, _devHeight;
//   TextEditingController searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     _devHeight = MediaQuery.of(context).size.height;
//     _devWidth = MediaQuery.of(context).size.width;

//     // Add static riders
//     localMapController.riders.addAll([
//       LatLng(1.2921, 36.8219), // Nairobi
//       LatLng(0.3476, 32.5825), // Kampala
//       LatLng(-1.286389, 36.817223), // Nairobi CBD
//     ]);

//     return Scaffold(
//       appBar: AppBar(
//         title: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 child: Image.asset(
//                   "images/bodanative.png",
//                   fit: BoxFit.fill,
//                 ),
//                 height: _devHeight! * 0.07,
//                 width: _devWidth! * 0.15,
//               ),
//               Expanded(
//                 child: CustomTextInput(
//                   labelcolor: Colors.green,
//                   hint: "Search",
//                   height: 25,
//                   width: double.infinity,
//                   border2: BorderSide(
//                     color: AppColor.blue,
//                     width: 1,
//                   ),
//                   obsecureText: false,
//                   controller: searchController,
//                   suffixIcon: Icon(
//                     Icons.search,
//                     size: 20,
//                     color: AppColor.blue,
//                   ),
//                   label: "Search",
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: Obx(
//         () => Stack(
//           children: [
//             Opacity(
//               opacity: localMapController.loading.value ? .55 : 1,
//               child: GoogleMap(
//                 onMapCreated: (controller) {
//                   if (!localMapController.controller.isCompleted) {
//                     localMapController.controller.complete(controller);
//                   }
//                 },
//                 initialCameraPosition: CameraPosition(
//                   target: localMapController.currentLocation.value,
//                   zoom: 15,
//                 ),
//                 markers: {
//                   Marker(
//                     markerId: const MarkerId("Current position"),
//                     infoWindow: const InfoWindow(title: "Current position"),
//                     position: localMapController.currentLocation.value,
//                   ),
//                   ...localMapController.riders.map((rider) {
//                     return Marker(
//                       markerId: MarkerId(rider.toString()),
//                       position: rider,
//                       infoWindow: InfoWindow(
//                         title: "Boda Boda Rider",
//                         onTap: () {
//                           // Request ride from this rider
//                           localMapController.requestRide(rider);
//                         },
//                       ),
//                       icon: BitmapDescriptor.defaultMarkerWithHue(
//                           BitmapDescriptor.hueBlue),
//                     );
//                   }).toSet(),
//                 },
//               ),
//             ),
//             Visibility(
//               visible: localMapController.loading.value,
//               child: AlertDialog(
//                 content: Padding(
//                   padding: EdgeInsets.only(
//                     top: verticalSpace(context, .03),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const CircularProgressIndicator(
//                         color: Colors.pink,
//                       ),
//                       CustomSpacing(height: .02),
//                       CustomText(
//                         text: "Please wait...",
//                         fontSize: 14,
//                         textColor: Colors.grey.shade600,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             if (localMapController.requestedRider.value != null)
//               Positioned(
//                 bottom: 20,
//                 left: 20,
//                 right: 20,
//                 child: Container(
//                   color: Colors.white,
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       Text(
//                         "Request Ride",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Text("Do you want to request a ride from this rider?"),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ElevatedButton(
//                             onPressed: () {
//                               localMapController.acceptRide();
//                             },
//                             child: Text("Yes"),
//                           ),
//                           ElevatedButton(
//                             onPressed: () {
//                               localMapController.requestedRider.value = null;
//                             },
//                             child: Text("No"),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             if (localMapController.rideAccepted.value)
//               Positioned(
//                 bottom: 20,
//                 left: 20,
//                 right: 20,
//                 child: Container(
//                   color: Colors.white,
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       Text(
//                         "Ride Accepted",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Text("The rider has accepted your request."),
//                       SizedBox(height: 10),
//                       ElevatedButton(
//                         onPressed: () {
//                           localMapController.rideAccepted.value = false;
//                           localMapController.requestedRider.value = null;
//                         },
//                         child: Text("OK"),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }