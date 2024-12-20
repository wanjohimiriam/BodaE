


// ignore_for_file: prefer_const_constructors, unused_import, sized_box_for_whitespace

import 'dart:async';
// import 'package:flutter/material.dart';
import 'package:drivers/views/loading/splash_screen_view_model.dart';
import 'package:drivers/widgets/colors.dart';
import 'package:drivers/widgets/space.dart';
import 'package:drivers/widgets/spacing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class LoadingScreen extends StatelessWidget {
  LoadingScreen({super.key});
  final SplashScreenViewModel splashScreenViewModel = Get.find<SplashScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: verticalSpace(context, .225),
              width: horizontalSpace(context, .5),
              child: Image.asset(
                "images/bodanative.png",
              ),
            ).animate(
              controller: splashScreenViewModel.animationController!,
              effects: [
                ScaleEffect(
                  begin: Offset(.5, .5),
                  end: Offset(1, 1),
                  duration: const Duration(seconds: 2),
                ),
                FadeEffect(
                  begin: .3,
                  end: 1,
                  duration: const Duration(seconds: 1),
                  delay: const Duration(milliseconds: 0)
                ),
              ],
            ),
            CustomSpacing(height: .05),
            Transform.scale(
              scale: 1.5, child: CupertinoActivityIndicator(
                color: AppColor.blue,
              ),
            )
          ],
        ),
      )
    );
  }
}