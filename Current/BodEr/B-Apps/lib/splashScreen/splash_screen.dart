import 'dart:async';

import 'package:drivers/views/loading/user_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTimer() async {
    Timer(const Duration(seconds: 5), () {
      Get.off(() => UserStatus());
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform.scale(
          scale: .4,
          child: Image(
            image: AssetImage("images/bodanative.png"),
          ).animate(
            effects: [
              FadeEffect(
                begin: .3,
                end: 1,
                duration: const Duration(seconds: 3),
                delay: const Duration(seconds: 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
