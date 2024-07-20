// ignore_for_file: prefer_const_constructors, unused_import, sized_box_for_whitespace

import 'dart:async';
import 'dart:ffi';

import 'package:bodae/Constants/colors.dart';
import 'package:bodae/auth/homelogin.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? _devWidth, _devHeight;
  double _progress = 0.0;
  bool _dialogShown = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startProgress();
  }

  void _startProgress() {
    _timer = Timer.periodic(Duration(milliseconds: 20), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _progress += 0.01;
        if (_progress >= 0.7) {
          _navigateToLoginPage();
          timer.cancel();
        }
      });
    });
  }
  void _navigateToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeLogin()),
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
            height:_devHeight!*0.15,
            width: _devWidth!*0.3,
            child: Image.asset("images/bikebodar.png",
            fit: BoxFit.fill,)),
          SizedBox(
            height: _devHeight!*0.09,
          ),
          // Container(
          //   height: _devHeight!*0.002,
          //   width: _devWidth!*0.17,
          //   color: AppColor.blue,
          // )
           Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: LinearProgressIndicator(
                value: _progress,
                minHeight: 5,
                color: AppColor.white,
                borderRadius: BorderRadius.circular(10),
                backgroundColor: AppColor.blue,
                semanticsLabel: 'Linear progress indicator',
              ),
            ),
        ],
      )),
    );
  }
}
