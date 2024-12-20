import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_boder/payment/paymentPop.dart';
import 'package:user_boder/screens/languagePop.dart';
import 'package:user_boder/screens/login_screen.dart';
import 'package:user_boder/screens/main_screen.dart';
import 'package:user_boder/screens/register_screen.dart';
import 'package:user_boder/splashScreen/splash_screen.dart';
import 'package:user_boder/translations/translations.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    GetMaterialApp(
      translations: TranslatedStrings(), // Set the translation class
      locale: Locale('en'), // Default locale
      fallbackLocale: Locale('en'), 
      debugShowCheckedModeBanner: false,
      initialRoute: "/paymentpop",
      getPages: [
        GetPage(name: "/", page: () => LoadingScreen(),),
       // GetPage(name: "/login", page: () => LoginScreen()),
        GetPage(name: "/langpop", page: () => LanguagePopUp(onLanguageSelected: () {},)),
       // GetPage(name: "/register", page: () => RegisterScreen()),
        
       // GetPage(name: "/mainScreen", page: () => MainScreen()),
        // GetPage(name: "/homelogin", page: () => HomeLogin()),
        // GetPage(name: "/signin", page: () => SignInScreen()),
        // GetPage(name: "/signup", page: () => SignUpScreen()),
        // GetPage(name: "/map", page: () => MapScreen(localMapController: LocalMapController(),)),
       //GetPage(name:  "/payment", page: () => PaymentPlan()),
        // GetPage(name: "/langpop", page: () => LanguagePopUp(onLanguageSelected: () {},)),
        // GetPage(name: "/changePassword", page: ()=> Changepassword()),
        // GetPage(name: "/profile", page: ()=> EditProfile()),
        // GetPage(name: "/maptwo", page: ()=> MapPage(localMapController: LocalMapController(),)),
        GetPage(name: "/paymentpop", page: ()=> PaymentPopUp())
      ]
    ));
}
