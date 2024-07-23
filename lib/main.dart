// ignore_for_file: prefer_const_constructors

import 'package:bodae/Pages/home_screen.dart';
import 'package:bodae/Pages/homepage.dart';
import 'package:bodae/payment/payment.dart';
import 'package:bodae/Pages/splashscreen.dart';
import 'package:bodae/auth/homelogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  MpesaFlutterPlugin.setConsumerKey("Sza3SsUB83e1UfcNyOlJyuqxAxAgxJUT8z6UOSYtvrOz8qyy");
  MpesaFlutterPlugin.setConsumerSecret("agJYb9HDGzMWnZtd40TBB7bcrYAG1UtNnInhz8ngRoGn16Aut9m4RTtqBVofd5Vv");
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => HomeScreen(),
      },
    )
  );
}