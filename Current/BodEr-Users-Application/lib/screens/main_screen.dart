// import 'dart:async';
// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating/flutter_rating.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:location/location.dart' as loc;
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:skeletonizer/skeletonizer.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:user_boder/controllers/main_screen_controller.dart';
// import 'package:user_boder/models/active_nearby_available_drivers.dart';
// import 'package:user_boder/Assistants/black_theme_google_map.dart';
// import 'package:user_boder/screens/drawer_screen.dart';
// import 'package:user_boder/screens/precise_pickup_location.dart';
// import 'package:user_boder/screens/search_places_screen.dart';
// import 'package:user_boder/services/formatings.dart';
// import 'package:user_boder/widgets/space.dart';
// import 'package:user_boder/widgets/spacing.dart';
// import 'package:user_boder/widgets/text.dart';

// Future<void> makePhoneCall(String url) async {
//   Uri uri = Uri.parse(url);
//   if(await canLaunchUrl(uri)) {
//     await launchUrl(uri);
//   }
//   else {
//     throw "Could not launch $url";
//   }
// }

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {

//   LatLng? pickLocation;
//   loc.Location location = loc.Location();
//   String? address;
//   var counter = 0;

//   final Completer<GoogleMapController> _controllerGoogleMap = Completer();
//   final MainScreenController mainScreenController = Get.put(MainScreenController());
//   GoogleMapController? newGoogleMapController;

//   final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

//   double searchLocationContainerHeight = 220;
//   double waitingResponsefromDriverContainerHeight = 0;
//   double assignedDriverInfoContainerHeight = 0;
//   double suggestedRidesContainerHeight = 0;
//   double searchingForDriverContainerHeight = 0;

//   Position? userCurrentPosition;
//   var geoLocation = Geolocator();

//   double bottomPaddingOfMap = 0;

//   List<LatLng> pLineCoOrdinatesList = [];
//   Set<Polyline> polylineSet = {};

//   // DatabaseReference? referenceRideRequest;

//   String selectedVehicleType = "";

//   String driverRideStatus = "driver_is_coming".tr;
//   StreamSubscription<DatabaseEvent>? tripRidesRequestInfoStreamSubscription;

//   List<ActiveNearByAvailableDrivers> onlineNearByAvailableDriversList = [];

//   String userRideRequestStatus = "";
//   bool requestPositionInfo = true;

//   locateUserPosition() async {
//     Position cPostion = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     userCurrentPosition = cPostion;

//     LatLng latLngPosition = LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);
//     CameraPosition cameraPosition = CameraPosition(target: latLngPosition, zoom: 15);

//     newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Obx(
//         () => Opacity(
//           opacity: mainScreenController.loading.value ? .35 : 1,
//           child: Scaffold(
//             key: _scaffoldState,
//             drawer: const DrawerScreen(),
//             body: Stack(
//               children: [
//                 Obx(
//                   () => GoogleMap(
//                     padding: EdgeInsets.only(top: 30, bottom: bottomPaddingOfMap),
//                     mapType: MapType.normal,
//                     myLocationEnabled: true,
//                     zoomGesturesEnabled: true,
//                     zoomControlsEnabled: true,
//                     initialCameraPosition: mainScreenController.initialCameraPosition.value,
//                     polylines: {
//                       Polyline(
//                         polylineId: PolylineId("directions_for_client".tr),
//                         points: mainScreenController.allPolylinePoints,
//                         width: 5,
//                         color: darkTheme ? Colors.blue.shade300 : Colors.blue.shade700,
//                       ),
//                     },
//                     onMapCreated: (GoogleMapController controller){
//                       _controllerGoogleMap.complete(controller);
//                       newGoogleMapController = controller;
//                       if(darkTheme == true){
//                         setState(() {
//                           blackThemeGoogleMap(newGoogleMapController);
//                         });
//                       }
//                       setState(() {
//                         bottomPaddingOfMap = 200;
//                       });
//                       locateUserPosition();
//                     },
//                   ),
//                 ),
//                 Positioned(
//                   top: 50,
//                   left: 20,
//                   child: SizedBox(
//                     child: GestureDetector(
//                       onTap: () {
//                         _scaffoldState.currentState!.openDrawer();
//                       },
//                       child: CircleAvatar(
//                         backgroundColor: darkTheme ? const Color(0xFF0E9EDC) : Colors.white,
//                         child: Icon(
//                           Icons.menu,
//                           color: darkTheme ? Colors.black : Colors.lightBlue,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 //ui for searching location
//                 Positioned(
//                   bottom: 0,
//                   left: 0,
//                   right: 0,
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: darkTheme ? Colors.black : Colors.white,
//                             borderRadius: BorderRadius.circular(10)
//                           ),
//                           child: Column(
//                             children: [
//                               Obx(
//                                 () => Opacity(
//                                   opacity: mainScreenController.play.value % 2 == 0 ? .99 : 1,
//                                   child: StreamBuilder<Map<String, dynamic>?>(
//                                     stream: mainScreenController.tripStatus(),
//                                     builder: (context, snapshot) {
//                                       if(snapshot.hasError || !snapshot.hasData){
//                                         return Skeletonizer(
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               color: darkTheme ? Colors.grey.shade900 : Colors.grey.shade100,
//                                               borderRadius: BorderRadius.circular(10),
//                                             ),
//                                             child: Column(
//                                               children: [
//                                                 Padding(
//                                                   padding: const EdgeInsets.all(5),
//                                                   child: Row(
//                                                     children: [
//                                                       Icon(Icons.location_on_outlined, color: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),),
//                                                       const SizedBox(width: 10,),
//                                                       Column(
//                                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                                         children: [
//                                                           Text("from".tr,
//                                                             style: TextStyle(
//                                                               color: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),
//                                                               fontSize: 12,
//                                                               fontWeight: FontWeight.bold,
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                             width: horizontalSpace(context, .7),
//                                                             child: Obx(
//                                                               () => Text(
//                                                                 mainScreenController.pickupLocation.value == "" ? "where_from".tr : mainScreenController.pickupLocation.value,
//                                                                 style: const TextStyle(
//                                                                   color: Colors.grey, 
//                                                                   fontSize: 14
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           )
//                                                         ],
//                                                       )
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 const SizedBox(height: 5,),
//                                                 Divider(
//                                                   height: 1,
//                                                   thickness: 2,
//                                                   color: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),
//                                                 ),
//                                                 const SizedBox(height: 5,),
//                                                 Padding(
//                                                   padding: const EdgeInsets.all(5),
//                                                   child: Row(
//                                                     children: [
//                                                       Icon(Icons.location_on_outlined, color: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),),
//                                                       const SizedBox(width: 10,),
//                                                       Column(
//                                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                                         children: [
//                                                           Text("to".tr,
//                                                             style: TextStyle(
//                                                               color: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),
//                                                               fontSize: 12,
//                                                               fontWeight: FontWeight.bold,
//                                                             ),
//                                                           ),
//                                                           Obx(
//                                                             () => SizedBox(
//                                                               width: horizontalSpace(context, .7),
//                                                               child: Text(
//                                                                 mainScreenController.destinationLocation.value == "" ? "where_to".tr : mainScreenController.destinationLocation.value,
//                                                                 style: const TextStyle(
//                                                                   color: Colors.grey, 
//                                                                   fontSize: 14
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       )
//                                                     ],
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         );
//                                       } else {
//                                         return Obx(
//                                           () => Container(
//                                             decoration: BoxDecoration(
//                                               color: darkTheme ? Colors.grey.shade900 : Colors.grey.shade100,
//                                               borderRadius: BorderRadius.circular(10),
//                                             ),
//                                             child: !mainScreenController.checkPrice.value && (snapshot.data!.isEmpty) ? Column(
//                                               children: [
//                                                 Padding(
//                                                   padding: const EdgeInsets.all(5),
//                                                   child: Row(
//                                                     children: [
//                                                       Icon(Icons.location_on_outlined, color: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),),
//                                                       const SizedBox(width: 10,),
//                                                       Column(
//                                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                                         children: [
//                                                           Text("from".tr,
//                                                             style: TextStyle(
//                                                               color: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),
//                                                               fontSize: 12,
//                                                               fontWeight: FontWeight.bold,
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                             width: horizontalSpace(context, .7),
//                                                             child: Obx(
//                                                               () => Text(
//                                                                 mainScreenController.pickupLocation.value == "" ? "where_from" : mainScreenController.pickupLocation.value,
//                                                                 style: const TextStyle(
//                                                                   color: Colors.grey, 
//                                                                   fontSize: 14
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           )
//                                                         ],
//                                                       )
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 const SizedBox(height: 5,),
//                                                 Divider(
//                                                   height: 1,
//                                                   thickness: 2,
//                                                   color: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),
//                                                 ),
//                                                 const SizedBox(height: 5,),
//                                                 Padding(
//                                                   padding: const EdgeInsets.all(5),
//                                                   child: GestureDetector(
//                                                     onTap: () async {
//                                                       String? responseFromSearchScreen = await Get.to(() => SearchPlacesScreen());
//                                                       if(responseFromSearchScreen != null){
//                                                         mainScreenController.destinationLocation.value = responseFromSearchScreen;
//                                                       }
//                                                     },
//                                                     child: Row(
//                                                       children: [
//                                                         Icon(Icons.location_on_outlined, color: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),),
//                                                         const SizedBox(width: 10,),
//                                                         Column(
//                                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                                           children: [
//                                                             Text("to".tr,
//                                                               style: TextStyle(
//                                                                 color: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),
//                                                                 fontSize: 12,
//                                                                 fontWeight: FontWeight.bold,
//                                                               ),
//                                                             ),
//                                                             Obx(
//                                                               () => SizedBox(
//                                                                 width: horizontalSpace(context, .7),
//                                                                 child: Text(
//                                                                   mainScreenController.destinationLocation.value == "" ? "where_to" : mainScreenController.destinationLocation.value,
//                                                                   style: const TextStyle(
//                                                                     color: Colors.grey, 
//                                                                     fontSize: 14
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 )
//                                               ],
//                                             ) : mainScreenController.checkPrice.value ? SizedBox(
//                                               width: double.infinity,
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(8.0),
//                                                 child: Column(
//                                                   mainAxisAlignment: MainAxisAlignment.start,
//                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                   mainAxisSize: MainAxisSize.min,
//                                                   children: [
//                                                     Row(
//                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                       children: [
//                                                         CustomText(
//                                                           text: "looking_for_rider".tr,
//                                                           fontSize: 18,
//                                                           textColor: darkTheme ? Colors.white : Colors.black,
//                                                           fontWeight: FontWeight.bold,
//                                                           textDecoration: TextDecoration.none,
//                                                           backgroundColor: Colors.transparent,
//                                                         ),
//                                                         CustomText(
//                                                           text: formatPrice(mainScreenController.price.value),
//                                                           fontSize: 18,
//                                                           textColor: darkTheme ? Colors.blue : Colors.blue.shade800,
//                                                           fontWeight: FontWeight.bold,
//                                                           textDecoration: TextDecoration.none,
//                                                           backgroundColor: Colors.transparent,
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     Padding(
//                                                       padding: EdgeInsets.symmetric(vertical: verticalSpace(context, .02)),
//                                                       child: Center(
//                                                         child: AvatarGlow(
//                                                           animate: false,
//                                                           duration: const Duration(milliseconds: 2500),
//                                                           startDelay: const Duration(seconds: 1),
//                                                           curve: Curves.easeIn,
//                                                           glowColor: Colors.blue.shade200,
//                                                           glowCount: 5,
//                                                           glowRadiusFactor: .20,
//                                                           child: const Image(
//                                                             image: AssetImage("images/Bike.png"),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ) : !snapshot.data!['driver_accepted'.tr] ? SizedBox(
//                                               width: double.infinity,
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(8.0),
//                                                 child: Column(
//                                                   mainAxisAlignment: MainAxisAlignment.start,
//                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                   mainAxisSize: MainAxisSize.min,
//                                                   children: [
//                                                     Row(
//                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                       children: [
//                                                         CustomText(
//                                                           text: "looking_for_rider".tr,
//                                                           fontSize: 18,
//                                                           textColor: darkTheme ? Colors.white : Colors.black,
//                                                           fontWeight: FontWeight.bold,
//                                                           textDecoration: TextDecoration.none,
//                                                           backgroundColor: Colors.transparent,
//                                                         ),
//                                                         CustomText(
//                                                           text: formatPrice(snapshot.data!['price'.tr] as double),
//                                                           fontSize: 18,
//                                                           textColor: darkTheme ? Colors.blue : Colors.blue.shade800,
//                                                           fontWeight: FontWeight.bold,
//                                                           textDecoration: TextDecoration.none,
//                                                           backgroundColor: Colors.transparent,
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     Padding(
//                                                       padding: EdgeInsets.symmetric(vertical: verticalSpace(context, .02)),
//                                                       child: Center(
//                                                         child: AvatarGlow(
//                                                           animate: true,
//                                                           duration: const Duration(milliseconds: 2500),
//                                                           startDelay: const Duration(seconds: 1),
//                                                           curve: Curves.easeIn,
//                                                           glowColor: Colors.blue.shade200,
//                                                           glowCount: 5,
//                                                           glowRadiusFactor: .20,
//                                                           child: const Image(
//                                                             image: AssetImage("images/Bike.png"),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ) : !snapshot.data!['driver_arrive'.tr] ? SizedBox(
//                                               width: double.infinity,
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(8.0),
//                                                 child: Column(
//                                                   mainAxisAlignment: MainAxisAlignment.start,
//                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                   mainAxisSize: MainAxisSize.min,
//                                                   children: [
//                                                     Row(
//                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                       children: [
//                                                         CustomText(
//                                                           text: "Wait for rider to arrive...",
//                                                           fontSize: 18,
//                                                           textColor: darkTheme ? Colors.white : Colors.black,
//                                                           fontWeight: FontWeight.bold,
//                                                           textDecoration: TextDecoration.none,
//                                                           backgroundColor: Colors.transparent,
//                                                         ),
//                                                         CustomText(
//                                                           text: formatPrice(snapshot.data!['price'] as double),
//                                                           fontSize: 18,
//                                                           textColor: darkTheme ? Colors.blue : Colors.blue.shade800,
//                                                           fontWeight: FontWeight.bold,
//                                                           textDecoration: TextDecoration.none,
//                                                           backgroundColor: Colors.transparent,
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     Padding(
//                                                       padding: EdgeInsets.symmetric(vertical: verticalSpace(context, .02)),
//                                                       child: Center(
//                                                         child: AvatarGlow(
//                                                           animate: true,
//                                                           duration: const Duration(milliseconds: 2500),
//                                                           startDelay: const Duration(seconds: 1),
//                                                           curve: Curves.easeIn,
//                                                           glowColor: Colors.blue.shade200,
//                                                           glowCount: 5,
//                                                           glowRadiusFactor: .20,
//                                                           child: const Image(
//                                                             image: AssetImage("images/Bike.png"),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ) : snapshot.data!['driver_arrive'] ? SizedBox(
//                                               width: double.infinity,
//                                               child: Padding(
//                                                 padding: const EdgeInsets.all(8.0),
//                                                 child: Column(
//                                                   mainAxisAlignment: MainAxisAlignment.start,
//                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                   mainAxisSize: MainAxisSize.min,
//                                                   children: [
//                                                     Row(
//                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                       children: [
//                                                         CustomText(
//                                                           text: "Safe Journey...",
//                                                           fontSize: 18,
//                                                           textColor: darkTheme ? Colors.white : Colors.black,
//                                                           fontWeight: FontWeight.bold,
//                                                           textDecoration: TextDecoration.none,
//                                                           backgroundColor: Colors.transparent,
//                                                         ),
//                                                         CustomText(
//                                                           text: formatPrice(snapshot.data!['price'] as double),
//                                                           fontSize: 18,
//                                                           textColor: darkTheme ? Colors.blue : Colors.blue.shade800,
//                                                           fontWeight: FontWeight.bold,
//                                                           textDecoration: TextDecoration.none,
//                                                           backgroundColor: Colors.transparent,
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ) : const SizedBox(),
//                                           ),
//                                         );
//                                       }
//                                     }
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 5,),
//                               Obx(
//                                 () => Opacity(
//                                   opacity: mainScreenController.play.value % 2 == 0 ? .99 : 1,
//                                   child: StreamBuilder<Map<String, dynamic>>(
//                                     stream: mainScreenController.tripStatus(),
//                                     builder: (context, snapshot) {
//                                       if(snapshot.hasError || !snapshot.hasData){
//                                         return const SizedBox();
//                                       } else {
//                                         return Obx(
//                                           () => Container(
//                                             child: !mainScreenController.checkPrice.value && (snapshot.data!.isEmpty) ? Row(
//                                               mainAxisAlignment: MainAxisAlignment.center,
//                                               children: [
//                                                 ElevatedButton(
//                                                   onPressed: () {
//                                                     Get.to(() => const PrecisePickUpScreen());
//                                                   },
//                                                   style: ElevatedButton.styleFrom(
//                                                     backgroundColor: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),
//                                                     textStyle: const TextStyle(
//                                                       fontWeight: FontWeight.bold,
//                                                       fontSize: 16,
//                                                     )
//                                                   ),
//                                                   child: Text(
//                                                     "Change Pick Up Address",
//                                                     style: TextStyle(
//                                                       color: darkTheme ? Colors.black : Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 const SizedBox(width: 10,),
//                                                 ElevatedButton(
//                                                   onPressed: () {
//                                                     if(mainScreenController.pickupLocation.value != "" && mainScreenController.destinationLocation.value != ""){
//                                                       mainScreenController.polylinePointDirections();
//                                                       mainScreenController.checkPrice.value = true;
//                                                     } else {
//                                                       Get.snackbar("Failed!!!", "Please input your pickup and destination address.");
//                                                     }
//                                                   },
//                                                   style: ElevatedButton.styleFrom(
//                                                     backgroundColor: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),
//                                                     textStyle: const TextStyle(
//                                                       fontWeight: FontWeight.bold,
//                                                       fontSize: 16,
//                                                     )
//                                                   ),
//                                                   child: Text(
//                                                     "Show Fare",
//                                                     style: TextStyle(
//                                                       color: darkTheme ? Colors.black : Colors.white,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ) : mainScreenController.checkPrice.value ? Row(
//                                               mainAxisAlignment: MainAxisAlignment.center,
//                                               children: [
//                                                 ElevatedButton(
//                                                   onPressed: () {
//                                                     mainScreenController.checkPrice.value = false;
//                                                   },
//                                                   style: ElevatedButton.styleFrom(
//                                                     backgroundColor: darkTheme ? const Color.fromARGB(255, 236, 21, 75).withOpacity(.7) : const Color.fromARGB(255, 236, 21, 75).withOpacity(.7),
//                                                     textStyle: const TextStyle(
//                                                       fontWeight: FontWeight.bold,
//                                                       fontSize: 16,
//                                                     )
//                                                   ),
//                                                   child: Text(
//                                                     "Change Location",
//                                                     style: TextStyle(
//                                                       color: darkTheme ? Colors.black : Colors.white,
//                                                       fontWeight: FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 const SizedBox(width: 10,),
//                                                 ElevatedButton(
//                                                   onPressed: () async {
//                                                     await mainScreenController.requestTrip();
//                                                   },
//                                                   style: ElevatedButton.styleFrom(
//                                                     backgroundColor: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),
//                                                     textStyle: const TextStyle(
//                                                       fontWeight: FontWeight.bold,
//                                                       fontSize: 16,
//                                                     )
//                                                   ),
//                                                   child: Text(
//                                                     "Request Ride",
//                                                     style: TextStyle(
//                                                       color: darkTheme ? Colors.black : Colors.white,
//                                                       fontWeight: FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ) : !snapshot.data!['driver_accepted'] ? Row(
//                                               mainAxisAlignment: MainAxisAlignment.center,
//                                               children: [
//                                                 ElevatedButton(
//                                                   onPressed: () {
//                                                     mainScreenController.cancelRequest();
//                                                   },
//                                                   style: ElevatedButton.styleFrom(
//                                                     backgroundColor: darkTheme ? const Color.fromARGB(255, 236, 21, 75).withOpacity(.7) : const Color.fromARGB(255, 236, 21, 75).withOpacity(.7),
//                                                     textStyle: const TextStyle(
//                                                       fontWeight: FontWeight.bold,
//                                                       fontSize: 16,
//                                                     )
//                                                   ),
//                                                   child: Text(
//                                                     "Cancel Request",
//                                                     style: TextStyle(
//                                                       color: darkTheme ? Colors.black : Colors.white,
//                                                       fontWeight: FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ) : const SizedBox(),
//                                           ),
//                                         );
//                                       }
//                                     }
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Obx(
//                   () => Opacity(
//                     opacity: mainScreenController.play.value % 2 == 0 ? .99 : 1,
//                     child: StreamBuilder<Map<String, dynamic>>(
//                       stream: mainScreenController.tripStatus(),
//                       builder: (context, snapshot) {
//                         if(snapshot.hasData){
//                           return Visibility(
//                             visible: snapshot.data!.isNotEmpty && snapshot.data!['trip_ended'],
//                             child: Positioned(
//                               child: Center(
//                                 child: AlertDialog(
//                                   content: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           CustomText(
//                                             text: "Price", 
//                                             fontSize: 18, 
//                                             textColor: darkTheme ? Colors.white : Colors.black,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                           CustomText(
//                                             text: formatPrice(snapshot.data!['price'] ?? 0.0 as double),
//                                             fontSize: 18, 
//                                             textColor: darkTheme ? Colors.white : Colors.black,
//                                             fontWeight: FontWeight.bold,
//                                           )
//                                         ],
//                                       ),
//                                       CustomSpacing(height: .02),
//                                       Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           CustomText(
//                                             text: "Rate Driver",
//                                             fontSize: 12,
//                                             textColor: darkTheme ? Colors.grey.shade200 : Colors.grey.shade800,
//                                           ),
//                                           Obx(
//                                             () => StarRating(
//                                               size: 35,
//                                               mainAxisAlignment: MainAxisAlignment.start,
//                                               allowHalfRating: true,
//                                               rating: mainScreenController.rating.value,
//                                               onRatingChanged: (value){
//                                                 mainScreenController.rating.value = value;
//                                               },
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       CustomSpacing(height: .025),
//                                       Align(
//                                         alignment: Alignment.bottomRight,
//                                         child: ElevatedButton(
//                                           onPressed: (){
//                                             mainScreenController.cancelRequest();
//                                           },
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor: darkTheme ? Colors.grey.shade100 : Colors.blue,
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(6),
//                                             )
//                                           ),
//                                           child: CustomText(
//                                             text: "Pay Fare",
//                                             fontSize: 18,
//                                             textColor: darkTheme ? Colors.grey.shade900 : Colors.grey.shade100,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ),
//                           );
//                         } else {
//                           return const SizedBox();
//                         }
//                       }
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }











