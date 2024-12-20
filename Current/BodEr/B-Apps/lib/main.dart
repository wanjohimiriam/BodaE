import 'package:drivers/translations/translations.dart';
import 'package:drivers/views/authentication/authentication_view_model.dart';
import 'package:drivers/views/authentication/forgot_password_screen.dart';
import 'package:drivers/views/authentication/login_screen.dart';
import 'package:drivers/views/authentication/register_screen.dart';
import 'package:drivers/views/homepage/homepage_view_model.dart';
import 'package:drivers/views/homepage/main_screen/main_screen_view_model.dart';
import 'package:drivers/views/homepage/pending_trips/pending_trips_screen.dart';
import 'package:drivers/views/homepage/pending_trips/pending_trips_view_model.dart';
import 'package:drivers/views/homepage/travel_screen/travel_screen_view_model.dart';
import 'package:drivers/views/homepage/trip_status.dart';
import 'package:drivers/views/loading/splash_screen.dart';
import 'package:drivers/views/loading/splash_screen_view_model.dart';
import 'package:drivers/views/loading/user_status.dart';
import 'package:drivers/views/loading/user_status_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");

  runApp(
    GetMaterialApp(
      translations: TranslatedStrings(),
      locale: Locale('en'),
      fallbackLocale: Locale('en'), 
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
          iconTheme: IconThemeData(
            size: 25,
            color: Colors.grey.shade900,
          ),
          centerTitle: true,
        ),
      ),
      debugShowCheckedModeBanner: false,
      getPages: [
        // AUTH SCREENS
        GetPage(
          name: "/",
          page: () => LoadingScreen(),
          binding: BindingsBuilder((){
            Get.lazyPut<SplashScreenViewModel>(() => SplashScreenViewModel());
          }),
        ),
        GetPage(
          name: "/userStatus",
          page: () => UserStatus(),
          binding: BindingsBuilder((){
            Get.lazyPut<UserStatusViewModel>(() => UserStatusViewModel());
            Get.lazyPut<HomepageViewModel>(() => HomepageViewModel(), fenix: true);
            Get.lazyPut<MainScreenViewModel>(() => MainScreenViewModel(), fenix: true);
            Get.lazyPut<TravelScreenViewModel>(() => TravelScreenViewModel(), fenix: true);
            Get.lazyPut<AuthenticationViewModel>(() => AuthenticationViewModel(firebaseAuth: FirebaseAuth.instance), fenix: true);
          }),
        ),
        GetPage(
          name: "/login", page: () => LoginScreen(),
          binding: BindingsBuilder((){
            Get.lazyPut<AuthenticationViewModel>(() => AuthenticationViewModel(firebaseAuth: FirebaseAuth.instance), fenix: true);
          })
        ),
        GetPage(
          name: "/register", page: () => RegisterScreen(),
          binding: BindingsBuilder((){
            Get.lazyPut<AuthenticationViewModel>(() => AuthenticationViewModel(firebaseAuth: FirebaseAuth.instance), fenix: true);
          })
        ),
        GetPage(
          name: "/forgotPassword", page: () => ForgotPasswordScreen(),
          binding: BindingsBuilder((){
            Get.lazyPut<AuthenticationViewModel>(() => AuthenticationViewModel(firebaseAuth: FirebaseAuth.instance), fenix: true);
          })
        ),

        // HOME SCREENS
        GetPage(
          name: "/mainScreen", page: () => TripStatus(),
          binding: BindingsBuilder((){
            Get.lazyPut<HomepageViewModel>(() => HomepageViewModel(), fenix: true);
            Get.lazyPut<MainScreenViewModel>(() => MainScreenViewModel(), fenix: true);
            Get.lazyPut<AuthenticationViewModel>(() => AuthenticationViewModel(firebaseAuth: FirebaseAuth.instance), fenix: true);
          }),
        ),
        GetPage(
          name: "/pendingTrips", page: () => PendingTripsScreen(),
          binding: BindingsBuilder((){
            Get.lazyPut<PendingTripsViewModel>(() => PendingTripsViewModel());
            Get.lazyPut<HomepageViewModel>(() => HomepageViewModel());
          }),
        ),
      ]
    ),
  );
}