// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:user_boder/controllers/user_controller.dart';
// import 'package:user_boder/screens/forgot_password_screen.dart';
// import 'package:user_boder/screens/register_screen.dart';
// import 'package:user_boder/widgets/spacing.dart';
// import 'package:user_boder/widgets/text.dart';
// import 'package:user_boder/widgets/text_form_field.dart';

// class LoginScreen extends StatelessWidget {
//   LoginScreen({super.key});
//   final UserController userController = Get.put(UserController());
//   double? _devWidth, _devHeight;

//   @override
//   Widget build(BuildContext context) {
//     _devHeight = MediaQuery.of(context).size.height;
//     _devWidth = MediaQuery.of(context).size.width;
//     bool darkTheme =
//         MediaQuery.of(context).platformBrightness == Brightness.dark;
//     return GestureDetector(
//       onTap: () {
//         if (!userController.loading.value) {
//           FocusScope.of(context).unfocus();
//         }
//       },
//       child: Scaffold(
//         body: Obx(
//           () => Stack(
//             children: [
//               Opacity(
//                 opacity: userController.loading.value ? .35 : 1,
//                 child: ListView(
//                   padding: const EdgeInsets.all(0),
//                   children: [
//                     Form(
//                       key: userController.loginKey,
//                       child: Column(
//                         children: [
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           Container(
//                             child: Image.asset('images/bodanative.png'),
//                             height: _devHeight! * 0.3,
//                             width: _devWidth! * 0.5,
//                           ),
//                           // Image.asset(darkTheme ? 'images/bodanative.png' : 'images/bodanative.png'),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             "welcome_back".tr,
//                             style: TextStyle(
//                               color: darkTheme
//                                   ? const Color(0xFF0E9EDC)
//                                   : const Color(0xFF0E9EDC),
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),

//                           Padding(
//                             padding: const EdgeInsets.fromLTRB(15, 20, 15, 50),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     CustomTextFormField(
//                                       controller: userController.email,
//                                       darkTheme: darkTheme,
//                                       textCapitalization:
//                                           TextCapitalization.none,
//                                       keyboardType: TextInputType.emailAddress,
//                                       label: "email".tr,
//                                       validator: (text) {
//                                         if (text == null || text.isEmpty) {
//                                           return 'Email can\'t be empty';
//                                         }
//                                         if (EmailValidator.validate(text) ==
//                                             true) {
//                                           return null;
//                                         }
//                                         if (text.length < 2) {
//                                           return "Please enter a valid email";
//                                         }
//                                         if (text.length > 99) {
//                                           return "Email can't be more than 100";
//                                         }
//                                         return null;
//                                       },
//                                       prefixIcon: Icon(
//                                         Icons.email,
//                                         color: darkTheme
//                                             ? const Color(0xFF0E9EDC)
//                                             : Colors.grey,
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 20,
//                                     ),
//                                     Obx(
//                                       () => CustomTextFormField(
//                                         controller: userController.password,
//                                         darkTheme: darkTheme,
//                                         obsecureText:
//                                             userController.obsecureValue.value,
//                                         label: "Password".tr,
//                                         validator: (text) {
//                                           if (text == null || text.isEmpty) {
//                                             return 'Password can\'t be empty';
//                                           }
//                                           if (text.length < 6) {
//                                             return "Please enter a valid password";
//                                           }
//                                           if (text.length > 49) {
//                                             return "Password can't be more than 50";
//                                           }
//                                           return null;
//                                         },
//                                         prefixIcon: Icon(
//                                           Icons.password,
//                                           color: darkTheme
//                                               ? const Color(0xFF0E9EDC)
//                                               : Colors.grey,
//                                         ),
//                                         suffixIcon: IconButton(
//                                           icon: Icon(
//                                             userController.obsecureValue.value
//                                                 ? Icons.visibility
//                                                 : Icons.visibility_off,
//                                             color: darkTheme
//                                                 ? const Color(0xFF0E9EDC)
//                                                 : Colors.grey,
//                                           ),
//                                           onPressed: () {
//                                             if (!userController.loading.value) {
//                                               userController
//                                                       .obsecureValue.value =
//                                                   !userController
//                                                       .obsecureValue.value;
//                                             }
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 20,
//                                     ),
//                                     ElevatedButton(
//                                         style: ElevatedButton.styleFrom(
//                                           backgroundColor: darkTheme
//                                               ? const Color(0xFF0E9EDC)
//                                               : const Color(0xFF0E9EDC),
//                                           foregroundColor: darkTheme
//                                               ? Colors.black
//                                               : Colors.white,
//                                           elevation: 0,
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(32),
//                                           ),
//                                           minimumSize:
//                                               const Size(double.infinity, 50),
//                                         ),
//                                         onPressed: () {
//                                           if (!userController.loading.value) {
//                                             if (userController
//                                                 .loginKey.currentState!
//                                                 .validate()) {
//                                               userController.loginUser();
//                                             }
//                                           }
//                                         },
//                                         child: Text(
//                                           "login".tr,
//                                           style: TextStyle(
//                                             fontSize: 20,
//                                           ),
//                                         )),
//                                     const SizedBox(
//                                       height: 20,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         if (!userController.loading.value) {
//                                           Get.off(() =>
//                                               const ForgotPasswordScreen());
//                                         }
//                                       },
//                                       child: Text(
//                                         'forgot_password'.tr,
//                                         style: TextStyle(
//                                           color: darkTheme
//                                               ? const Color(0xFF0E9EDC)
//                                               : const Color(0xFF0E9EDC),
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 20,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           'no_account'.tr,
//                                           style: TextStyle(
//                                             color: Colors.grey,
//                                             fontSize: 15,
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           width: 5,
//                                         ),
//                                         GestureDetector(
//                                           onTap: () {
//                                             if (!userController.loading.value) {
//                                               Get.off(() => RegisterScreen());
//                                             }
//                                           },
//                                           child: Text(
//                                             "register".tr,
//                                             style: TextStyle(
//                                               fontSize: 15,
//                                               color: darkTheme
//                                                   ? const Color(0xFF0E9EDC)
//                                                   : const Color(0xFF0E9EDC),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                                 CustomSpacing(height: .075),
//                                 GestureDetector(
//                                   onTap: () {
//                                     if (!userController.loading.value) {
//                                       userController.googleSignIn();
//                                     }
//                                   },
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(12),
//                                         color: darkTheme
//                                             ? Colors.black54
//                                             : Colors.grey.shade200,
//                                         border: Border.all(
//                                           width: 2,
//                                           color: darkTheme
//                                               ? Colors.black87
//                                               : Colors.grey.shade300,
//                                         )),
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 16, vertical: 8),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Image(
//                                             image:
//                                                 AssetImage('images/google.png'),
//                                             width: 45,
//                                             height: 45,
//                                           ),
//                                           CustomSpacing(width: .02),
//                                           CustomText(
//                                             text: "Sign_in_with_email".tr,
//                                             fontSize: 20,
//                                             textColor: darkTheme
//                                                 ? Colors.white
//                                                 : Colors.black,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Visibility(
//                 visible: userController.loading.value,
//                 child: const Positioned(
//                   child: Center(
//                     child: CircularProgressIndicator(color: Color(0xFF0E9EDC)),
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
