// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:user_boder/controllers/user_controller.dart';
// import 'package:user_boder/screens/login_screen.dart';
// import 'package:user_boder/widgets/spacing.dart';
// import 'package:user_boder/widgets/text_form_field.dart';

// class ForgotPasswordScreen extends StatefulWidget {
//   const ForgotPasswordScreen({super.key});


//   @override
//   State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
// }

// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   final UserController userController = Get.put(UserController());
//   double? _devWidth, _devHeight;

  
//   @override
//   Widget build(BuildContext context) {
//     _devHeight = MediaQuery.of(context).size.height;
//     _devWidth = MediaQuery.of(context).size.width;

//     bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         body: ListView(
//           padding: const EdgeInsets.all(0),
//           children: [
//             Column(
//               children: [
//                 //Image.asset(darkTheme ? 'images/city.jpg' : 'images/city.jpg'),
//                 const SizedBox(
//                             height: 20,
//                           ),
//                           Container(
//                             child: Image.asset('images/bodanative.png'),
//                             height: _devHeight! * 0.3,
//                             width: _devWidth! * 0.5,
//                           ),
                

//                 Text(
//                   'forgot_password_screen'.tr,
//                   style: TextStyle(
//                     color: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 const SizedBox(height: 20,),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(15, 20, 15, 50),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Form(
//                         key: userController.forgotPasswordKey,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             CustomTextFormField(
//                               controller: userController.email,
//                               darkTheme: darkTheme,
//                               textCapitalization: TextCapitalization.none,
//                               keyboardType: TextInputType.emailAddress,
//                               label: "email".tr,
//                               validator: (text) {
//                                 if(text == null || text.isEmpty){
//                                   return 'Email can\'t be empty';
//                                 }
//                                 if(EmailValidator.validate(text) == true){
//                                   return null;
//                                 }
//                                 if(text.length < 2) {
//                                   return "Please enter a valid email";
//                                 }
//                                 if(text.length > 99){
//                                   return "Email can't be more than 100";
//                                 }
//                                 return null;
//                               },
//                               prefixIcon: Icon(Icons.email, color: darkTheme ? const Color(0xFF0E9EDC) : Colors.grey,),
//                             ),
//                             CustomSpacing(height: .025),
//                             ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),
//                                 foregroundColor: darkTheme ? Colors.black : Colors.white,
//                                 elevation: 0,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(18),
//                                 ),
//                                 minimumSize: const Size(double.infinity, 50),
//                               ),
//                               onPressed: () {
//                                 if(userController.forgotPasswordKey.currentState!.validate()){
//                                   userController.resetPassword(userController.email.text.toLowerCase().trim());
//                                 }
//                               },
//                               child: Text(
//                                 'send_reset_password_link'.tr,
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                 ),
//                               )
//                             ),
//                             CustomSpacing(height: .05),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                  Text(
//                                   "already_have_account".tr,
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 15,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 5,),
//                                 GestureDetector(
//                                   onTap: () {
//                                     Get.off(() => LoginScreen());
//                                   },
//                                   child: Text(
//                                     "login".tr,
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       color: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             )

//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
