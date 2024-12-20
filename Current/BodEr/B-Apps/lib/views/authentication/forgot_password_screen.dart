import 'package:drivers/views/authentication/authentication_view_model.dart';
import 'package:drivers/widgets/colors.dart';
import 'package:drivers/widgets/space.dart';
import 'package:drivers/widgets/spacing.dart';
import 'package:drivers/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final AuthenticationViewModel authenticationViewModel = Get.find<AuthenticationViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Opacity(
          opacity: authenticationViewModel.loading ? .35 : 1,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: verticalSpace(context, .3),
                  width: horizontalSpace(context, .3),
                  child: Image.asset('images/bodanative.png'),
                ),
                Text(
                  'forgot_password_screen'.tr,
                  style: TextStyle(
                    color: AppColor.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        key: authenticationViewModel.forgotPasswordKey,
                        child: Column(
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
                                if(text == null || text.isEmpty){
                                  return 'Email can\'t be empty';
                                } else if(!text.isEmail){
                                  return "Please enter a valid email";
                                }
                                return null;
                              },
                              prefixIcon: Icon(Icons.email, color: AppColor.blue),
                            ),
                            CustomSpacing(height: .025),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.blue,
                                foregroundColor: AppColor.blue,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              onPressed: () {
                                if(authenticationViewModel.forgotPasswordKey.currentState!.validate()){
                                  authenticationViewModel.resetPassword(authenticationViewModel.email.text.toLowerCase().trim());
                                }
                              },
                              child: Text(
                                'send_reset_password_link'.tr,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColor.white
                                ),
                              )
                            ),
                            CustomSpacing(height: .05),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 Text(
                                  "already_have_account".tr,
                                  style: TextStyle(
                                    color: AppColor.grey,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(width: 5,),
                                GestureDetector(
                                  onTap: () {
                                    Get.offNamed('/login');
                                  },
                                  child: Text(
                                    "login".tr,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: AppColor.blue,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CustomSpacing(height: .2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
