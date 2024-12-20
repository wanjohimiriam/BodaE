// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:user_boder/controllers/user_controller.dart';
// import 'package:user_boder/screens/main_screen.dart';
// import 'package:user_boder/services/printing.dart';
// import 'package:user_boder/widgets/text.dart';

// class AuthService{
//   UserController authController;

//   AuthService({required this.authController});  
//   static Future<void> signInWithGoogle() async {
//     try{
//         // Begin sign-in process
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//       // Obtain auth request from request
//       final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

//       // Create new credential for user
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       // Finally sign in
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       await Get.off(() => const MainScreen());
//     } on PlatformException catch(e){
//       Printing.print(e.toString());
//       Get.dialog(
//         AlertDialog(
//           title: CustomText(
//             text: "Alert!!! ${e.code}", 
//             fontSize: 16, 
//             textColor: Colors.grey.shade900,
//             fontWeight: FontWeight.bold,
//           ),
//           content: CustomText(
//             text: e.message.toString(),
//             fontSize: 14, 
//             textColor: Colors.grey.shade700,
//             fontWeight: FontWeight.normal,
//           ),
//         ),
//         barrierDismissible: true,
//       );
//     }
//   }
// }