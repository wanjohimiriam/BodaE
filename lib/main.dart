// ignore_for_file: prefer_const_constructors

import 'package:bodae/payment/payment.dart';
import 'package:bodae/Pages/splashscreen.dart';
import 'package:bodae/auth/homelogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => PaymentPlan(),
      },
    )
  );
}