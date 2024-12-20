import 'package:drivers/views/authentication/authentication_view_model.dart';
import 'package:drivers/views/authentication/register_screen.dart';
import 'package:drivers/widgets/colors.dart';
import 'package:drivers/widgets/spacing.dart';
import 'package:drivers/widgets/text.dart';
import 'package:drivers/widgets/text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final AuthenticationViewModel authenticationViewModel = Get.find<AuthenticationViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            Opacity(
              opacity: authenticationViewModel.loading ? .35 : 1,
              child: ListView(
                padding: const EdgeInsets.all(0),
                children: [
                  Form(
                    key: authenticationViewModel.loginKey,
                    child: Column(
                      children: [
                        Image.asset('images/city.jpg'),
                        CustomSpacing(height: .025),
                        Text(
                          "welcome_back".tr,
                          style: TextStyle(
                            color: AppColor.blue,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 20, 15, 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomTextFormField(
                                    controller: authenticationViewModel.email,
                                    darkTheme: false,
                                    textCapitalization: TextCapitalization.none,
                                    keyboardType: TextInputType.emailAddress,
                                    label: "email".tr,
                                    hintText: 'johndoe@example.com',
                                    maxLength: 30,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Email can\'t be empty';
                                      } else if(!text.isEmail){
                                        return 'Invalid E-mail address';
                                      }
                                      return null;
                                    },
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: AppColor.blue,
                                    ),
                                  ),
                                  CustomSpacing(height: .02),
                                  Obx(
                                    () => CustomTextFormField(
                                      controller: authenticationViewModel.password,
                                      darkTheme: false,
                                      obsecureText: authenticationViewModel.obsecureValue,
                                      label: "Password".tr,
                                      maxLength: 12,
                                      hintText: '********',
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Password can\'t be empty';
                                        }
                                        else if (text.length < 8) {
                                          return "Password should have at least 8 characters long";
                                        }
                                        else if (text.length > 12) {
                                          return "Password can't be more than 12 characters long";
                                        }
                                        return null;
                                      },
                                      prefixIcon: Icon(
                                        Icons.password,
                                        color: AppColor.blue,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          authenticationViewModel.obsecureValue
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: AppColor.blue
                                        ),
                                        onPressed: () {
                                          if (!authenticationViewModel.loading) {
                                            authenticationViewModel.toggleVisibility();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  CustomSpacing(height: .035),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.blue,
                                      foregroundColor: AppColor.blue,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      minimumSize: const Size(double.infinity, 50),
                                    ),
                                    onPressed: () {
                                      if (!authenticationViewModel.loading) {
                                        if (authenticationViewModel.loginKey.currentState!.validate()) {
                                          authenticationViewModel.loginUser();
                                        }
                                      }
                                    },
                                    child: Text(
                                      "login".tr,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white
                                      ),
                                    )
                                  ),
                                  CustomSpacing(height: .02),
                                  GestureDetector(
                                    onTap: () {
                                      if (!authenticationViewModel.loading) {
                                        Get.offNamed('/forgotPassword');
                                      }
                                    },
                                    child: Text(
                                      'forgot_password'.tr,
                                      style: TextStyle(
                                        color: AppColor.blue
                                      ),
                                    ),
                                  ),
                                  CustomSpacing(height: .02),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'no_account'.tr,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (!authenticationViewModel.loading) {
                                            Get.off(() => RegisterScreen());
                                          }
                                        },
                                        child: Text(
                                          "register".tr,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: AppColor.blue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              CustomSpacing(height: .075),
                              GestureDetector(
                                onTap: () {
                                  if (!authenticationViewModel.loading) {
                                    authenticationViewModel.googleSignIn();
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColor.grey.withOpacity(.65),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image(
                                          image: AssetImage('images/google.png'),
                                          width: 45,
                                          height: 45,
                                        ),
                                        CustomSpacing(width: .02),
                                        CustomText(
                                          text: "Sign_in_with_email".tr,
                                          fontSize: 20,
                                          textColor: AppColor.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: authenticationViewModel.loading,
              child: Positioned(
                child: Center(
                  child: Transform.scale(scale: 1.5, child: CupertinoActivityIndicator(color: Color(0xFF0E9EDC))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
