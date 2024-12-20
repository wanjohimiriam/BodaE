// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:user_boder/controllers/user_controller.dart';
// import 'package:user_boder/screens/forgot_password_screen.dart';
// import 'package:user_boder/screens/login_screen.dart';
// import 'package:user_boder/widgets/text_form_field.dart';

// class RegisterScreen extends StatelessWidget {
//   RegisterScreen({super.key});

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
//                       key: userController.registerKey,
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
//                           //Image.asset(darkTheme ? 'images/city.jpg' : 'images/city.jpg'),

//                           Text(
//                             'WELCOME TO BodEr!!',
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
//                                       controller: userController.name,
//                                       darkTheme: darkTheme,
//                                       label: "Name",
//                                       textCapitalization:
//                                           TextCapitalization.words,
//                                       keyboardType: TextInputType.name,
//                                       prefixIcon: Icon(
//                                         Icons.person,
//                                         color: darkTheme
//                                             ? const Color(0xFF0E9EDC)
//                                             : Colors.grey,
//                                       ),
//                                       validator: (text) {
//                                         if (text == null || text.isEmpty) {
//                                           return 'Name can\'t be empty';
//                                         }
//                                         if (text.length < 2) {
//                                           return "Please enter a valid name";
//                                         }
//                                         if (text.length > 49) {
//                                           return "Name can't be more than 50";
//                                         }
//                                         return null;
//                                       },
//                                     ),
//                                     const SizedBox(
//                                       height: 20,
//                                     ),
//                                     CustomTextFormField(
//                                       controller: userController.email,
//                                       darkTheme: darkTheme,
//                                       textCapitalization:
//                                           TextCapitalization.none,
//                                       keyboardType: TextInputType.emailAddress,
//                                       label: "Email",
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
//                                     IntlPhoneField(
//                                       showCountryFlag: false,
//                                       controller: userController.phone,
//                                       keyboardType: TextInputType.number,
//                                       dropdownIcon: const Icon(
//                                         Icons.arrow_drop_down,
//                                         color: Color(0xFF0E9EDC),
//                                       ),
//                                       validator: (value) {
//                                         return value!.toString().length < 9
//                                             ? "Invalid phone number"
//                                             : null;
//                                       },
//                                       dropdownTextStyle: const TextStyle(
//                                         fontSize: 16,
//                                         color: Color(0xFF0E9EDC),
//                                       ),
//                                       style: TextStyle(
//                                         fontSize: 15,
//                                         color: darkTheme
//                                             ? Colors.white
//                                             : Colors.grey.shade900,
//                                       ),
//                                       decoration: InputDecoration(
//                                         hintText: "Phone",
//                                         hintStyle: const TextStyle(
//                                           color: Colors.grey,
//                                         ),
//                                         filled: true,
//                                         fillColor: darkTheme
//                                             ? Colors.black45
//                                             : Colors.grey.shade200,
//                                         border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(12),
//                                             borderSide: const BorderSide(
//                                               width: 0,
//                                               style: BorderStyle.none,
//                                             )),
//                                       ),
//                                       initialCountryCode: 'BD',
//                                     ),
//                                     CustomTextFormField(
//                                       controller: userController.address,
//                                       darkTheme: darkTheme,
//                                       textCapitalization:
//                                           TextCapitalization.sentences,
//                                       keyboardType: TextInputType.streetAddress,
//                                       prefixIcon: Icon(
//                                         Icons.person,
//                                         color: darkTheme
//                                             ? const Color(0xFF0E9EDC)
//                                             : Colors.grey,
//                                       ),
//                                       label: "Address",
//                                       validator: (text) {
//                                         if (text == null || text.isEmpty) {
//                                           return 'Address can\'t be empty';
//                                         }
//                                         if (text.length < 2) {
//                                           return "Please enter a valid address";
//                                         }
//                                         if (text.length > 99) {
//                                           return "Address can't be more than 100";
//                                         }
//                                         return null;
//                                       },
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
//                                         label: "password".tr,
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
//                                     CustomTextFormField(
//                                       controller:
//                                           userController.confirmPassword,
//                                       darkTheme: darkTheme,
//                                       obsecureText:
//                                           userController.obsecureValue.value,
//                                       label: "confirm_password".tr,
//                                       validator: (text) {
//                                         return text !=
//                                                 userController
//                                                     .confirmPassword.text
//                                             ? "passwords_do_not_match".tr
//                                             : null;
//                                       },
//                                       prefixIcon: Icon(Icons.password,
//                                           color: darkTheme
//                                               ? const Color(0xFF0E9EDC)
//                                               : Colors.grey),
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
//                                                 BorderRadius.circular(15),
//                                           ),
//                                           minimumSize:
//                                               const Size(double.infinity, 50),
//                                         ),
//                                         onPressed: () {
//                                           if (!userController.loading.value) {
//                                             if (userController
//                                                 .registerKey.currentState!
//                                                 .validate()) {
//                                               userController.registerUser();
//                                             }
//                                           }
//                                         },
//                                         child: Text(
//                                           'register'.tr,
//                                           style: TextStyle(
//                                             fontSize: 25,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         )),
//                                     const SizedBox(
//                                       height: 20,
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         if (!userController.loading.value) {
//                                           Get.to(() =>
//                                               const ForgotPasswordScreen());
//                                         }
//                                       },
//                                       child: Text(
//                                         'forgot_passowrd'.tr,
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
//                                          Text(
//                                           "have_an_account".tr,
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
//                                               Get.off(() => LoginScreen());
//                                             }
//                                           },
//                                           child: Text(
//                                             "sign_in".tr,
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
