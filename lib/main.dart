// ignore_for_file: prefer_const_constructors

import 'package:bodae/Constants/colors.dart';
import 'package:bodae/Pages/homepage.dart';
import 'package:bodae/Pages/splashscreen.dart';
import 'package:bodae/auth/changepassword.dart';
import 'package:bodae/auth/homelogin.dart';
import 'package:bodae/auth/profile.dart';
import 'package:bodae/auth/signup.dart';
import 'package:bodae/auth/signin.dart';
import 'package:bodae/widgets/drawer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.white),
        //useMaterial3: true,
      ),
      home: LoadingScreen(),
    );
  }
}

