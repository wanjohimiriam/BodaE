import 'package:drivers/views/homepage/homepage_view_model.dart';
import 'package:drivers/views/homepage/travel_screen/travel_screen_view_model.dart';
import 'package:drivers/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TravelScreen extends StatelessWidget {
  TravelScreen({super.key, required this.pickupLocation, required this.destinationLocation});
  final String pickupLocation;
  final String destinationLocation;
  final HomepageViewModel homepageViewModel = Get.find<HomepageViewModel>();
  final TravelScreenViewModel travelScreenViewModel = Get.find<TravelScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => Opacity(
              opacity: homepageViewModel.loading ? .35 : 1,
              child: Obx(
                () => GoogleMap(
                  style: homepageViewModel.styleString,
                  padding: EdgeInsets.only(top: 30),
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: homepageViewModel.currentLocation,
                    zoom: homepageViewModel.zoom,
                  ),
                  markers: {
                    // Current Position Marker
                    Marker(
                      markerId: MarkerId("Progressive Location"),
                      icon: AssetMapBitmap('assets/icons/motorbike.png', width: 50, height: 50),
                      position: travelScreenViewModel.cameraPosition,
                    ),

                    // Destination Marker
                    if(homepageViewModel.allPolylinePoints.isNotEmpty)
                      Marker(
                        markerId: MarkerId("Destination Location"),
                        icon: AssetMapBitmap('assets/icons/destination.png', width: 40, height: 40),
                        position: homepageViewModel.allPolylinePoints.last,
                      ),
                  },
                  polylines: {
                    Polyline(
                      polylineId: PolylineId('My Journey'),
                      points: homepageViewModel.allPolylinePoints,
                      color: AppColor.blue,
                      width: 7,
                    ),
                  },
                  onMapCreated: (GoogleMapController controller) async {
                    if(!homepageViewModel.completer.isCompleted){
                      homepageViewModel.completer.complete(controller);
                    }
                    await homepageViewModel.polylinePointFromAdress(pickupLocation, destinationLocation);
                    homepageViewModel.setZoom(15);
                    homepageViewModel.animateToPosition(travelScreenViewModel.cameraPosition);
                    // travelScreenViewModel.setCameraPosition(homepageViewModel.allPolylinePoints.first);
                  },
                ),
              ),
            ),
          ),
          // Obx(
          //   () => Visibility(
          //     visible: travelScreenViewModel.tripStatus.isNotEmpty,
          //     child: Positioned(
          //       bottom: 0,
          //       child: Container(
          //         constraints: BoxConstraints(
          //           maxHeight: verticalSpace(context, .35),
          //           minHeight: verticalSpace(context, .05),
          //           maxWidth: horizontalSpace(context, 1),
          //           minWidth: horizontalSpace(context, 1),
          //         ),
          //         decoration: BoxDecoration(
          //           color: Colors.white.withOpacity(.85),
          //           borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(30),
          //             topRight: Radius.circular(30),
          //           )
          //         ),
          //         child: StreamBuilder(
          //           stream: homepageViewModel.tripStatus(),
          //           builder: (_, snapshot){
          //             if(snapshot.hasData){
          //               List data = snapshot.data!.docs.where(
          //                 (doc) => doc['driver'] == FirebaseAuth.instance.currentUser!.email!
          //               ).toList();
          //               if(data.isEmpty){
          //                 return Container();
          //               }
          //               if (data['driver'] == null) {
          //                 return Container(
          //                   decoration: BoxDecoration(
          //                     color: Colors.white.withOpacity(.75),
          //                     borderRadius: BorderRadius.only(
          //                       topLeft: Radius.circular(30),
          //                       topRight: Radius.circular(30),
          //                     )
          //                   ),
          //                   child: Padding(
          //                     padding: const EdgeInsets.symmetric(
          //                       horizontal: 16,
          //                       vertical: 16,
          //                     ),
          //                     child: Container(
          //                       decoration: BoxDecoration(
          //                         color: AppColor.grey.withOpacity(.25),
          //                         borderRadius: BorderRadius.circular(3)
          //                       ),
          //                       child: Padding(
          //                         padding: const EdgeInsets.all(8.0),
          //                         child: Column(
          //                           crossAxisAlignment: CrossAxisAlignment.start,
          //                           mainAxisSize: MainAxisSize.min,
          //                           children: [
          //                             CustomText(
          //                               text: 'Requesting Rider...please wait...', 
          //                               fontSize: 18, 
          //                               textColor: AppColor.black.withOpacity(.9),
          //                               fontWeight: FontWeight.bold,
          //                             ),
          //                             Expanded(child: SizedBox()),
          //                             Center(
          //                               child: AvatarGlow(
          //                                 glowRadiusFactor: 1.1,
          //                                 glowColor: AppColor.blue,
          //                                 child: Image(
          //                                   image: AssetImage('images/Bike.png'),
          //                                 ),
          //                               ),
          //                             ),
          //                             Padding(
          //                               padding: EdgeInsets.symmetric(horizontal: horizontalSpace(context, .05)),
          //                               child: TextButton(
          //                                 onPressed: (){
                                            
          //                                 },
          //                                 style: TextButton.styleFrom(
          //                                   backgroundColor: Colors.green,
          //                                   shape: RoundedRectangleBorder(
          //                                     borderRadius: BorderRadius.circular(30),
          //                                   )
          //                                 ),
          //                                 child: Row(
          //                                   mainAxisAlignment: MainAxisAlignment.center,
          //                                   children: [
          //                                     CustomText(
          //                                       text: "Cancel Trip",
          //                                       fontSize: 25,
          //                                       textColor: AppColor.white,
          //                                       fontWeight: FontWeight.bold,
          //                                     ),
          //                                     CustomSpacing(width: .025),
          //                                     Icon(
          //                                       Icons.cancel,
          //                                       color: Colors.red.withOpacity(.7),
          //                                       size: 30,
          //                                     ),
          //                                   ],
          //                                 )
          //                               ),
          //                             ),
          //                             Expanded(child: SizedBox()),
          //                           ],
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 );
          //               } else if(data['driver'] != null && data['driver_arrive'] == false){
          //                 travelScreenViewModel.streamDriverLocation(data['driver']);
          //                 return Padding(
          //                   padding: const EdgeInsets.all(16.0),
          //                   child: Container(
          //                     decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(3),
          //                       color: AppColor.grey.withOpacity(.25),
          //                     ),
          //                     child: Padding(
          //                       padding: const EdgeInsets.all(8.0),
          //                       child: Column(
          //                         mainAxisSize: MainAxisSize.min,
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         children: [
          //                           CustomText(
          //                             text: 'Wait for rider to arrive...', 
          //                             fontSize: 18, 
          //                             textColor: AppColor.black,
          //                             fontWeight: FontWeight.bold,
          //                           ),
          //                           Expanded(child: SizedBox()),
          //                           Padding(
          //                             padding: EdgeInsets.symmetric(horizontal: horizontalSpace(context, .05)),
          //                             child: TextButton(
          //                               onPressed: (){
                                          
          //                               },
          //                               style: TextButton.styleFrom(
          //                                 backgroundColor: Colors.green,
          //                                 shape: RoundedRectangleBorder(
          //                                   borderRadius: BorderRadius.circular(30),
          //                                 )
          //                               ),
          //                               child: Row(
          //                                 mainAxisAlignment: MainAxisAlignment.center,
          //                                 children: [
          //                                   CustomText(
          //                                     text: "Cancel Trip",
          //                                     fontSize: 25,
          //                                     textColor: AppColor.white,
          //                                     fontWeight: FontWeight.bold,
          //                                   ),
          //                                   CustomSpacing(width: .025),
          //                                   Icon(
          //                                     Icons.cancel,
          //                                     color: Colors.red.withOpacity(.75),
          //                                     size: 30,
          //                                   ),
          //                                 ],
          //                               )
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 );
          //               } else if(data['driver_arrive'] == true && data['trip_ended'] == false){
          //                 return Padding(
          //                   padding: const EdgeInsets.all(16.0),
          //                   child: Container(
          //                     decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(3),
          //                       color: AppColor.grey.withOpacity(.25),
          //                     ),
          //                     child: Padding(
          //                       padding: const EdgeInsets.all(8.0),
          //                       child: Column(
          //                         mainAxisSize: MainAxisSize.min,
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         children: [
          //                           CustomText(
          //                               text: 'Safe Journey...', 
          //                               fontSize: 18, 
          //                               textColor: AppColor.black,
          //                               fontWeight: FontWeight.bold,
          //                           ),
          //                           CustomSpacing(height: .02),
          //                           Padding(
          //                             padding: EdgeInsets.symmetric(horizontal: horizontalSpace(context, .05)),
          //                             child: TextButton(
          //                               onPressed: () async {
          //                                 await homepageViewModel.finishTrip();
          //                               },
          //                               style: TextButton.styleFrom(
          //                                 backgroundColor: Colors.green,
          //                                 shape: RoundedRectangleBorder(
          //                                   borderRadius: BorderRadius.circular(30),
          //                                 )
          //                               ),
          //                               child: Row(
          //                                 mainAxisAlignment: MainAxisAlignment.center,
          //                                 children: [
          //                                   CustomText(
          //                                     text: "Finish Trip",
          //                                     fontSize: 25,
          //                                     textColor: AppColor.white,
          //                                     fontWeight: FontWeight.bold,
          //                                   ),
          //                                   CustomSpacing(width: .025),
          //                                   Icon(
          //                                     Icons.verified,
          //                                     color: AppColor.blue.withOpacity(.75),
          //                                     size: 30,
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 );
          //               } else if(data['trip_ended'] == true && data['paid'] == false) {
          //                 return Padding(
          //                   padding: const EdgeInsets.all(16.0),
          //                   child: Container(
          //                     decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(3),
          //                       color: AppColor.grey.withOpacity(.25),
          //                     ),
          //                     child: Padding(
          //                       padding: const EdgeInsets.all(8.0),
          //                       child: Column(
          //                         mainAxisSize: MainAxisSize.min,
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         children: [
          //                           CustomText(
          //                               text: 'Pay for ride...', 
          //                               fontSize: 18, 
          //                               textColor: AppColor.black,
          //                               fontWeight: FontWeight.bold,
          //                           ),
          //                           CustomSpacing(height: .02),
          //                           Padding(
          //                             padding: EdgeInsets.symmetric(horizontal: horizontalSpace(context, .05)),
          //                             child: TextButton(
          //                               onPressed: () async {
                                          
          //                               },
          //                               style: TextButton.styleFrom(
          //                                 backgroundColor: Colors.green,
          //                                 shape: RoundedRectangleBorder(
          //                                   borderRadius: BorderRadius.circular(30),
          //                                 )
          //                               ),
          //                               child: Row(
          //                                 mainAxisAlignment: MainAxisAlignment.center,
          //                                 children: [
          //                                   CustomText(
          //                                     text: "Initiate Payment",
          //                                     fontSize: 25,
          //                                     textColor: AppColor.white,
          //                                     fontWeight: FontWeight.bold,
          //                                   ),
          //                                   CustomSpacing(width: .025),
          //                                   Icon(
          //                                     Icons.verified,
          //                                     color: AppColor.blue.withOpacity(.75),
          //                                     size: 30,
          //                                   ),
          //                                 ],
          //                               ),
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 );
          //               } else if(data['payment'] == true && data['payment_confirmed'] == false) {
          //                 return  Padding(
          //                   padding: const EdgeInsets.all(16.0),
          //                   child: Container(
          //                     decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(3),
          //                       color: AppColor.grey.withOpacity(.25),
          //                     ),
          //                     child: Padding(
          //                       padding: const EdgeInsets.all(8.0),
          //                       child: CustomText(
          //                         text: 'Waiting for rider to approve payment...', 
          //                         fontSize: 18, 
          //                         textColor: AppColor.black,
          //                         fontWeight: FontWeight.bold,
          //                       ),
          //                     ),
          //                   ),
          //                 );
          //               } else {
          //                 return Container();
          //               }
          //             } else {
          //               return Container();
          //             }
          //           }
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}