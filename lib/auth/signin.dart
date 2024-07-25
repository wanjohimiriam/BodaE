import 'package:bodae/Constants/colors.dart';
import 'package:bodae/Pages/home_screen.dart';
import 'package:bodae/widgets/textfields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  double? _devWidth, _devHeight;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        Get.toNamed("/home");
      } on FirebaseAuthException catch (e) {
        String message = '';
        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided for that user.';
        }
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _devHeight = MediaQuery.of(context).size.height;
    _devWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppColor.blue,
      //   leading: Icon(
      //     Icons.arrow_back_ios_sharp,
      //     color: Colors.white,
      //   ),
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Text(
      //         "SIGN IN",
      //         style: TextStyle(
      //             color: AppColor.white,
      //             fontSize: 18,
      //             fontWeight: FontWeight.bold),
      //       ),
      //       Container(
      //         child: Image.asset(
      //           "images/bodanative.png",
      //           fit: BoxFit.fill,
      //         ),
      //         height: _devHeight! * 0.05,
      //         width: _devWidth! * 0.15,
      //       )
      //     ],
      //   ),
      // ),
      body: Center(
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
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
                  Text(
                    'login with your details',
                    style: TextStyle(
                        color: AppColor.blue,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: _devHeight! * 0.08,
                  ),
                  CustomTextInput(
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: [AutofillHints.email],
                    controller: emailController,
                    label: "Enter email",
                    fontSize: 16,
                    hint: "wanj@gmail.com",
                    validator: (val) {
                      return val!.isEmpty ? "enter_email_error" : null;
                    },
                  ),
                  SizedBox(height: _devHeight! * 0.04),
                  CustomTextInput(
                    label: "Enter password",
                    controller: passwordController,
                    fontSize: 16,
                    validator: (val) {
                      return val!.isEmpty ? "enter_password_error" : null;
                    },
                    hint: "wanj@_Pass",
                  ),
                  SizedBox(height: _devHeight! * 0.02),
                  Padding(
                    padding: const EdgeInsets.only(left: 240),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed("/changePassword");
                      },
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                   SizedBox(height: _devHeight! * 0.06),
                  Center(
                    child: GestureDetector(
                      onTap: _signIn,
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
                  ),
                   SizedBox(height: _devHeight! * 0.01),

                  GestureDetector(
                    onTap: (){
                      Get.toNamed("/signup");
                    },
                    child: Text(
                      'Dont have an Account? Create',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 160, 211, 162),
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
