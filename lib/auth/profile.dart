// ignore_for_file: prefer_const_constructors

import 'package:bodae/Constants/colors.dart';
import 'package:bodae/widgets/textfields.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  double? _devWidth, _devHeight;

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
            Icon(
              Icons.menu,
              color: AppColor.white,
              size: 18,
            ),
            Text(
              "Edit Profile",
              style: TextStyle(
                  color: AppColor.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.arrow_back,
              color: AppColor.white,
              size: 18,
            ),
          ],
        ),
      ),
      body: Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Edit Profile",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: _devHeight! * 0.005,
          ),
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.black12,
            ),
          ),
          SizedBox(
            height: _devHeight! * 0.02,
          ),
          CustomTextInput(
            keyboardType: TextInputType.emailAddress,
            autofillHints: [AutofillHints.email],
            // controller: authController.email,
            label: "Enter your name",
            hint: "wanj@gmail.com",
            validator: (val) {
              return val!.isEmpty ? "enter_email_error" : null;
            },
          ),
          SizedBox(height: _devHeight! * 0.025),
          CustomTextInput(
            label: " Enter your email",
            // obsecureText: authController.invisible.value,
            // controller: authController.password,
            validator: (val) {
              return val!.isEmpty ? "enter_password_error" : null;
            },
            hint: "wanj@_Pass",
          ),
          SizedBox(height: _devHeight! * 0.02),
          CustomTextInput(
            label: "Enter your password",
            // obsecureText: authController.invisible.value,
            // controller: authController.password,
            validator: (val) {
              return val!.isEmpty ? "enter_password_error" : null;
            },
            hint: "wanj@_Pass",
          ),
          SizedBox(
            height: _devHeight! * 0.02,
          ),
          CustomTextInput(
            label: "Contact",
            // obsecureText: authController.invisible.value,
            // controller: authController.password,
            validator: (val) {
              return val!.isEmpty ? "enter_password_error" : null;
            },
            hint: "wanj@_Pass",
          ),
          SizedBox(height: _devHeight! * 0.02),
          CustomTextInput(
            label: "Address",
            // obsecureText: authController.invisible.value,
            // controller: authController.password,
            validator: (val) {
              return val!.isEmpty ? "enter_password_error" : null;
            },
            hint: "wanj@_Pass",
          ),
          SizedBox(height: _devHeight! * 0.02),
          CustomTextInput(
            label: "DOB",
            // obsecureText: authController.invisible.value,
            // controller: authController.password,
            validator: (val) {
              return val!.isEmpty ? "enter_password_error" : null;
            },
            hint: "wanj@_Pass",
          ),
          SizedBox(
            height: _devHeight! * 0.035,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13),
            child: Row(
              children: [
                Container(
                  child: Center(
                    child: Text(
                      "Update",
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  height: _devHeight! * 0.06,
                  width: _devWidth! * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.blue,
                  ),
                ),
                SizedBox(
                  width: _devWidth! * 0.03,
                ),
                Container(
                  child: Center(
                    child: Text(
                      "Delete Account",
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  height: _devHeight! * 0.06,
                  width: _devWidth! * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black12,
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
