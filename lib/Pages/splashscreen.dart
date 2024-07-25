// ignore_for_file: prefer_const_constructors, unused_import, sized_box_for_whitespace

import 'dart:async';

import 'package:bodae/Constants/colors.dart';
import 'package:bodae/Pages/languagepop.dart';
import 'package:bodae/auth/homelogin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? _devWidth, _devHeight;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startProgress();
  }

  void _startProgress() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (progress >= 1) {
        timer.cancel();
        _navigateToLoginPage();
      } else {
        setState(() {
          progress += 0.02;
        });

        if (progress >= 0.5 && progress < 0.52) {
          _showPopup();
        }
      }
    });
  }

  void _navigateToLoginPage() {
   Get.toNamed("/homelogin");
  }

  void _showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LanguagePopUp(
          onLanguageSelected: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _devHeight = MediaQuery.of(context).size.height;
    _devWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: _devHeight! * 0.15,
              width: _devWidth! * 0.3,
              child: Image.asset(
                "images/bikebodar.png",
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: _devHeight! * 0.09,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 5,
                color: AppColor.white,
                borderRadius: BorderRadius.circular(10),
                backgroundColor: AppColor.blue,
                semanticsLabel: 'Linear progress indicator',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
