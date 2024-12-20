// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:user_boder/screens/login_screen.dart';
// import 'package:user_boder/screens/main_screen.dart';
// import 'package:user_boder/services/login_service.dart';
// import 'package:user_boder/widgets/text.dart';

// class UserController extends GetxController{
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//   final TextEditingController name = TextEditingController();
//   final TextEditingController email = TextEditingController();
//   final TextEditingController phone = TextEditingController();
//   final TextEditingController address = TextEditingController();
//   final TextEditingController password = TextEditingController();
//   final TextEditingController confirmPassword = TextEditingController();
//   final GlobalKey<FormState> registerKey = GlobalKey<FormState>();
//   final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
//   final GlobalKey<FormState> forgotPasswordKey = GlobalKey<FormState>();
//   RxBool loading = false.obs;
//   RxBool obsecureValue = true.obs;
//   Future<void> registerUser() async {
//     loading.value = true;
//     try{
//       await firebaseAuth.createUserWithEmailAndPassword(
//         email: email.text.toLowerCase().trim(), 
//         password: password.text,
//       ).then(
//         (value) async {
//           await firebaseFirestore.collection('users').doc(value.user!.email).set(
//             {
//               'username': name.text,
//               'email': value.user!.email,
//               'phone': phone.text,
//               'address': address.text,
//               'image': null,
//               'status': 'user',
//             }
//           );
//         }
//       );
//       clearControllers();
//       loading.value = false;
//       await Get.off(() => const MainScreen());
//       disposeControllers();
//     } catch(e){
//       loading.value = false;
//       Get.snackbar(
//         "Failed!!!",
//         "$e",
//       );
//     }
//   }

//   Future<void> loginUser() async {
//     loading.value = true;
//     try{
//       await firebaseAuth.signInWithEmailAndPassword(
//         email: email.text.toLowerCase().trim(), 
//         password: password.text,
//       );
//       clearControllers();
//       loading.value = false;
//       await Get.off(() => const MainScreen());
//       disposeControllers();
//     } catch(e){
//       loading.value = false;
//       Get.snackbar(
//         "Failed!!!",
//         "$e",
//       );
//     }
//   }

//   Future<void> resetPassword(String email) async {
//     loading.value = true;
//     try{
//       List users = await firebaseFirestore.collection('users').get().then((value) => value.docs);
//       if(users.where((item) => item['email'] == email).toList().isNotEmpty){
//         await firebaseAuth.sendPasswordResetEmail(
//           email: email,
//         );
//       } else {
//         Get.snackbar(
//           "Error!!!",
//           'No user is recorded under this email address.'
//         );
//       }
//       Get.snackbar(
//         "Success", 
//         'Successfully sent the reset link. Visit email to reset link',
//         isDismissible: false,
//         duration: const Duration(minutes: 1),
//         mainButton: TextButton(
//           onPressed: () async {
//             Get.back();
//             await Get.off(() => LoginScreen());
//           },
//           style: TextButton.styleFrom(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5),
//             ),
//             backgroundColor: Colors.blue,
//           ),
//           child: CustomText(
//             text: "Done",
//             fontSize: 12,
//             textColor: Colors.white,
//             fontWeight: FontWeight.bold,
//           )
//         )
//       );
//       loading.value = false;
//     } catch(e){
//       loading.value = false;
//       Get.snackbar(
//         "Error!!",
//         '$e',
//       );
//     }
//   }

//   Future<void> googleSignIn() async {
//     loading.value = true;
//     await AuthService.signInWithGoogle();
//     loading.value = false;
//   }

//   void disposeControllers(){
//     name.dispose();
//     email.dispose();
//     address.dispose();
//     phone.dispose();
//     password.dispose();
//     confirmPassword.dispose();
//   }

//   void clearControllers(){
//     name.clear();
//     email.clear();
//     address.clear();
//     phone.clear();
//     password.clear();
//     confirmPassword.clear();
//   }
// }