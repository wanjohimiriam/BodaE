// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:io';

import 'package:bodae/Constants/colors.dart';
import 'package:bodae/Pages/HomeScreen.dart';
import 'package:bodae/widgets/textfields.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //AuthController authController = Get.put(AuthController());

  double? _devWidth, _devHeight;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool valuefirst = false;
  late DateTime selectedDate;
  ImagePicker picker = ImagePicker();
  File? image;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
  }

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
              "SIGN UP",
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
              height: _devHeight! * 0.045,
              width: _devWidth! * 0.15,
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: _devHeight! * 0.05,
                  ),
                  CustomTextInput(
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: [AutofillHints.email],
                    // controller: authController.email,
                    label: "First Name",
                    fontSize: 16,
                    hint: "Henry",
                    
                    validator: (val) {
                      return val!.isEmpty ? "enter_email_error" : null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextInput(
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: [AutofillHints.email],
                    label: "Last Name",
                    fontSize: 16,
                    hint: "Wanjohi",
                    validator: (val) {
                      return val!.isEmpty ? "enter_email_error" : null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextInput(
                    label: "Enter email",
                    fontSize: 16,
                    validator: (val) {
                      return val!.isEmpty ? "enter_password_error" : null;
                    },
                    hint: "wanj@gmail.com",
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
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                  child: CircleAvatar(
                    backgroundColor: AppColor.white2,
                    radius: 80,
                    child: CircleAvatar(
                      radius: 75, // This gives a small padding around the image
                      backgroundImage: image != null ? FileImage(image!) : null,
                      child: image == null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () => _getImage(ImageSource.camera),
                                  icon: Icon(Icons.camera_alt_outlined),
                                ),
                                SizedBox(width: 10),
                                IconButton(
                                  onPressed: () => _getImage(ImageSource.gallery),
                                  icon: Icon(Icons.photo_library_outlined),
                                ),
                              ],
                            )
                          : null,
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
                            "SIGN UP",
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
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
