// ignore_for_file: prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:bodae/auth/signup.dart';
import 'package:bodae/auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:bodae/Constants/colors.dart';

class HomeLogin extends StatefulWidget {
  const HomeLogin({super.key});

  @override
  State<HomeLogin> createState() => _HomeLoginState();
}

class _HomeLoginState extends State<HomeLogin> {
  double? _devWidth, _devHeight;

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool valuefirst = false;

  @override
  Widget build(BuildContext context) {
    _devHeight = MediaQuery.of(context).size.height;
    _devWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'WELCOME!',
            style: TextStyle(
                color: AppColor.blue,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          Container(
            child: Image.asset('images/bodanative.png'),
            height: _devHeight! * 0.3,
            width: _devWidth! * 0.5,
          ),
          SizedBox(
            height: _devHeight! * 0.11,
          ),
          TheForms(),
        ],
      ),
    ));
  }

  Widget TheForms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text("Already Have An Account?",
      style: TextStyle(
        color: Colors.blue,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),),
      SizedBox(height: 5,),
      GestureDetector(
        onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  SignInScreen()),
            );
          },
        child: Container(
            width: _devWidth! * 0.75,
            height: _devHeight! * 0.065,
            decoration: BoxDecoration(
              color: AppColor.blue,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColor.white,
                ),
              ),
            )),
      ),
      SizedBox(
        height: _devHeight! * 0.025,
      ),
      Text("Don't Have An Account? Lets Create",
      style: TextStyle(
        color: Colors.blue,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),),
      SizedBox(height: 5,),
      GestureDetector(
        onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  SignUpScreen()),
            );
          },
        child: Container(
            width: _devWidth! * 0.75,
            height: _devHeight! * 0.065,
            decoration: BoxDecoration(
                color: AppColor.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: AppColor.blue)),
            child: Center(
              child: Text(
                "SignIn",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColor.blue,
                ),
              ),
            )),
      ),
    ]);
  }
}
