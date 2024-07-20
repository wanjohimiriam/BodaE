// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:bodae/Constants/colors.dart';
import 'package:bodae/Pages/HomeScreen.dart';
import 'package:bodae/widgets/textfields.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  double? _devWidth, _devHeight;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool valuefirst = false;

  @override
  Widget build(BuildContext context) {
    _devHeight = MediaQuery.of(context).size.height;
    _devWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon(
            //   Icons.arrow_back,
            //   color: AppColor.white,
            //   size: 18,
            // ),
            Text(
              "SIGN IN",
              style: TextStyle(
                  color: AppColor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              child: Image.asset(
                "images/bodanative.png",
                fit: BoxFit.fill,
              ),
              height: _devHeight! * 0.05,
              width: _devWidth! * 0.15,
            )
          ],
        ),
      ),
      body: Center(
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: _devHeight! * 0.02,
                ),
                CustomTextInput(
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: [AutofillHints.email],
                  // controller: authController.email,
                  label: "Enter email",
                  fontSize: 16,
                  hint: "wanj@gmail.com",
                  validator: (val) {
                    return val!.isEmpty ? "enter_email_error" : null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextInput(
                  label: "Enter password",
                 fontSize: 16,
                  validator: (val) {
                    return val!.isEmpty ? "enter_password_error" : null;
                  },
                  hint: "wanj@_Pass",
                ),
                SizedBox(
                  height: _devHeight! * 0.025,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 240),
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: _devHeight! * 0.1,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return HomeScreen();
                        }));
                      }
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        "SIGN IN",
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      height: _devHeight! * 0.06,
                      width: _devWidth! * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.blue,
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
