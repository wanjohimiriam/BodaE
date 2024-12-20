// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:user_boder/global/global.dart';
// import 'package:user_boder/screens/profile_screen.dart';
// import 'package:user_boder/screens/trips_history_screen.dart';
// import 'package:user_boder/splashScreen/splash_screen.dart';

// class DrawerScreen extends StatelessWidget {
//   const DrawerScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 220,
//       child: Drawer(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(30, 50, 0, 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(30),
//                     decoration: const BoxDecoration(
//                       color: Colors.lightBlue,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.person,
//                       color: Colors.white,
//                     ),
//                   ),

//                   const SizedBox(height: 20,),

//                   const Text(
//                     "Username Here",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                     ),
//                   ),

//                   const SizedBox(height: 10,),

//                   GestureDetector(
//                     onTap: () {
//                       Get.to(() => const ProfileScreen());
//                     },
//                     child: const Text(
//                       "Edit Profile",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 15,
//                         color: Color(0xFF0E9EDC),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 30,),

//                   GestureDetector(
//                     onTap: () {
//                       Get.to(() => const TripsHistoryScreen());
//                     },
//                     child: const Text("Your Trips", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),)
//                   ),

//                   const SizedBox(height: 15,),

//                   const Text("Payment", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),

//                   const SizedBox(height: 15,),

//                   const Text("Notifications", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),

//                   const SizedBox(height: 15,),

//                   const Text("Promos", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),

//                   const SizedBox(height: 15,),

//                   const Text("Help", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),

//                   const SizedBox(height: 15,),

//                   const Text("Free Trips", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),

//                   const SizedBox(height: 15,),

//                 ],
//               ),

//               GestureDetector(
//                 onTap: () {
//                   firebaseAuth.signOut();
//                   Get.to(() => const LoadingScreen());
//                 },
//                 child: const Text(
//                   "Logout",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                     color: Colors.red,
//                   ),
//                 ),
//               ),

//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
