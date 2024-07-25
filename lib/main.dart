// ignore_for_file: prefer_const_constructors

import 'package:bodae/Maps/map_controller.dart';
import 'package:bodae/Maps/maps.dart';
import 'package:bodae/Maps/maptwo.dart';
import 'package:bodae/Pages/home_screen.dart';
import 'package:bodae/Pages/languagepop.dart';
import 'package:bodae/Pages/paymentpo.dart';
import 'package:bodae/auth/changepassword.dart';
import 'package:bodae/auth/profile.dart';
import 'package:bodae/auth/signin.dart';
import 'package:bodae/auth/signup.dart';
import 'package:bodae/payment/payment.dart';
import 'package:bodae/Pages/splashscreen.dart';
import 'package:bodae/auth/homelogin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  MpesaFlutterPlugin.setConsumerKey("Sza3SsUB83e1UfcNyOlJyuqxAxAgxJUT8z6UOSYtvrOz8qyy");
  MpesaFlutterPlugin.setConsumerSecret("agJYb9HDGzMWnZtd40TBB7bcrYAG1UtNnInhz8ngRoGn16Aut9m4RTtqBVofd5Vv");
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => LoadingScreen(),),
        GetPage(name: "/home", page: () => HomeScreen()),
        GetPage(name: "/homelogin", page: () => HomeLogin()),
        GetPage(name: "/signin", page: () => SignInScreen()),
        GetPage(name: "/signup", page: () => SignUpScreen()),
        GetPage(name: "/map", page: () => MapScreen(localMapController: LocalMapController(),)),
        GetPage(name:  "/payment", page: () => PaymentPlan()),
        GetPage(name: "/langpop", page: () => LanguagePopUp(onLanguageSelected: () {},)),
        GetPage(name: "/changePassword", page: ()=> Changepassword()),
        GetPage(name: "/profile", page: ()=> EditProfile()),
        GetPage(name: "/maptwo", page: ()=> MapPage(localMapController: LocalMapController(),)),
        GetPage(name: "/paymentpop", page: ()=> PaymentPopUp())
      ]
    )
  );
}