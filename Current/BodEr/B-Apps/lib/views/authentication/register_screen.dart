import 'package:drivers/views/authentication/authentication_view_model.dart';
import 'package:drivers/views/authentication/login_screen.dart';
import 'package:drivers/widgets/colors.dart';
import 'package:drivers/widgets/spacing.dart';
import 'package:drivers/widgets/text.dart';
import 'package:drivers/widgets/text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

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
                    key: authenticationViewModel.registerKey,
                    child: Column(
                      children: [
                        Image.asset('images/city.jpg'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Welcome to BodEr!!!',
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
                                    controller: authenticationViewModel.name,
                                    darkTheme: false,
                                    label: "Name",
                                    hintText: 'John Doe',
                                    textCapitalization: TextCapitalization.words,
                                    keyboardType: TextInputType.name,
                                    maxLength: 20,
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: AppColor.blue
                                    ),
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Name can\'t be empty';
                                      }
                                      else if (text.length < 3) {
                                        return "Please enter a valid name";
                                      }
                                      else if (text.length > 30) {
                                        return "Name can't be more than 30";
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomSpacing(height: .02),
                                  CustomTextFormField(
                                    controller: authenticationViewModel.email,
                                    darkTheme: false,
                                    textCapitalization: TextCapitalization.none,
                                    keyboardType: TextInputType.emailAddress,
                                    label: "Email",
                                    maxLength: 30,
                                    hintText: 'johndoe@example.com',
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
                                      color: AppColor.blue
                                    ),
                                  ),
                                  CustomSpacing(height: .02),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8, bottom: 20),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: CustomText(
                                            text: '+254',
                                            fontSize: 16,
                                            textColor: AppColor.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          child: CustomTextFormField(
                                            controller: authenticationViewModel.phone, 
                                            darkTheme: false, 
                                            label: "Phone number",
                                            maxLength: 9,
                                            hintText: '700000000',
                                            keyboardType: TextInputType.number,
                                            validator: (value){
                                              return value!.length < 9 ? 'Invalid phone number' : null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  CustomTextFormField(
                                    controller: authenticationViewModel.address,
                                    darkTheme: false,
                                    textCapitalization: TextCapitalization.sentences,
                                    keyboardType: TextInputType.streetAddress,
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: AppColor.blue
                                    ),
                                    hintText: 'Nairobi, Kenya',
                                    label: "Address",
                                    maxLength: 30,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Address can\'t be empty';
                                      }
                                      else if (text.length < 5) {
                                        return "Please enter a valid address";
                                      }
                                      else if (text.length > 99) {
                                        return "Address can't be more than 100";
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomSpacing(height: .02),
                                  Obx(
                                    () => CustomTextFormField(
                                      controller: authenticationViewModel.password,
                                      darkTheme: false,
                                      obsecureText: authenticationViewModel.obsecureValue,
                                      label: "password".tr,
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
                                        color: AppColor.blue
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          authenticationViewModel.obsecureValue ? Icons.visibility : Icons.visibility_off,
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
                                  CustomSpacing(height: .02),
                                  CustomTextFormField(
                                    controller: authenticationViewModel.confirmPassword,
                                    darkTheme: false,
                                    obsecureText: authenticationViewModel.obsecureValue,
                                    label: "confirm_password".tr,
                                    hintText: '********',
                                    maxLength: 12,
                                    validator: (text) {
                                      return text != authenticationViewModel.confirmPassword.text ? "passwords_do_not_match".tr : null;
                                    },
                                    prefixIcon: Icon(
                                      Icons.password,
                                      color: AppColor.blue
                                    ),
                                  ),
                                  CustomSpacing(height: .035),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.blue,
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      minimumSize: const Size(double.infinity, 50),
                                    ),
                                    onPressed: () {
                                      if (!authenticationViewModel.loading) {
                                        if (authenticationViewModel.registerKey.currentState!.validate()) {
                                          authenticationViewModel.registerUser();
                                        }
                                      }
                                    },
                                    child: Text(
                                      'register'.tr,
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ),
                                  CustomSpacing(height: .035),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "have_an_account".tr,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                        ),
                                      ),
                                      CustomSpacing(width: .005),
                                      GestureDetector(
                                        onTap: () {
                                          if (!authenticationViewModel.loading) {
                                            Get.off(() => LoginScreen());
                                          }
                                        },
                                        child: Text(
                                          "sign_in".tr,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: AppColor.blue
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
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
                  child: Transform.scale(scale: 1.5, child: CupertinoActivityIndicator(color: AppColor.blue)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
