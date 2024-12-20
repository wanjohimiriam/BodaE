// ignore_for_file: prefer_const_constructors

import 'package:driver_boder/Views/Widgets/colors.dart';
import 'package:flutter/material.dart';

class Mythemes{
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
    appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: AppColor.black,
          ), // Change the back button color
          backgroundColor:
              AppColor.black)
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
     appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: AppColor.blue,
          ), // Change the back button color
          backgroundColor:
              AppColor.blue,)
  );
}