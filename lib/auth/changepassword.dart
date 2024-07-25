// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:bodae/Constants/colors.dart';
import 'package:bodae/widgets/textfields.dart';
import 'package:flutter/material.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
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
      appBar: AppBar(
        backgroundColor: AppColor.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "CHANGE PASSWORD",
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
            child: SingleChildScrollView(
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
                hint: "wanj@gmail.com",
                validator: (val) {
                  return val!.isEmpty ? "enter_email_error" : null;
                },
              ),
              SizedBox(height: _devHeight! * 0.025),
              CustomTextInput(
                label: "New password",
                // obsecureText: authController.invisible.value,
                // controller: authController.password,
                validator: (val) {
                  return val!.isEmpty ? "enter_password_error" : null;
                },
                hint: "wanj@_Pass",
              ),
              SizedBox(height: _devHeight! * 0.025),
              CustomTextInput(
                label: "Confirm password",
                // obsecureText: authController.invisible.value,
                // controller: authController.password,
                validator: (val) {
                  return val!.isEmpty ? "enter_password_error" : null;
                },
                hint: "wanj@_Pass",
              ),
              SizedBox(
                height: _devHeight! * 0.05,
              ),
              Center(
                child: Container(
                  child: Center(
                    child: Text(
                      "UPDATE",
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  height: _devHeight! * 0.06,
                  width: _devWidth! * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.blue,
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
