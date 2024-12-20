// ignore_for_file: prefer_const_constructors

import 'package:driver_boder/Views/Auth/changepassword.dart';
import 'package:driver_boder/Views/Auth/profile.dart';
import 'package:driver_boder/Views/Auth/signin.dart';
import 'package:driver_boder/Views/Auth/signup.dart';
import 'package:driver_boder/Views/pages/maps.dart';
import 'package:driver_boder/Views/pages/myThemes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Views/Widgets/colors.dart';
import 'Views/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: Mythemes.lightTheme,
      darkTheme: Mythemes.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: "/signIn",
      getPages: [
        // GetPage(name: "/", page: () => LoadingScreen()),
        //GetPage(name: "/homeL", page: () => HomeLogin()),
        GetPage(name: "/signIn", page: () => SignInScreen()),
        GetPage(name: "/mapH", page: () => MapsHomeScreen()),
        GetPage(name: "/signUp", page: () => SignUpScreen()),
        GetPage(name: "/changePassword", page: () => Changepassword()),
        GetPage(name: "/profile", page: () => EditProfile()),
        //GetPage(name: "/map", page: () => MapPage(localMapController: LocalMapController(),)),
        GetPage(name: "/home", page: () => HomePage()),
        //GetPage(name: "/payment", page: () => PaymentPopUp()),
    ]);
  }
}