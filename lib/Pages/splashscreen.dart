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

  @override

  void initState() {

    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    HomeLogin()
            )
        )
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
            height: _devHeight!*0.01,
          ),
          Container(
            height: _devHeight!*0.002,
            width: _devWidth!*0.17,
            color: AppColor.blue,
          )
        ],
      )),
    );
  }
}
