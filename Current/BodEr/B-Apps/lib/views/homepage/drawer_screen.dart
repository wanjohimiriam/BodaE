import 'package:drivers/views/authentication/authentication_view_model.dart';
import 'package:drivers/widgets/space.dart';
import 'package:drivers/widgets/spacing.dart';
import 'package:drivers/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DrawerScreen extends StatelessWidget {
  DrawerScreen({super.key, required this.authenticationViewModel});
  final currentUser = FirebaseAuth.instance.currentUser!;
  final AuthenticationViewModel authenticationViewModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: horizontalSpace(context, .8),
        child: Padding(
          padding: EdgeInsets.only(left: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              CustomDrawerItems(
                text: 'Pending Trips',
                onTap: () {
                  Get.toNamed('/pendingTrips');
                },
              ),
              CustomDrawerItems(
                text: 'Notifications',
                onTap: () {},
              ),
              CustomDrawerItems(
                text: 'Promos',
                onTap: () {},
              ),
              CustomDrawerItems(
                text: 'Help',
                onTap: () {},
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: (){
                    authenticationViewModel.signOut();
                  },
                  child: CustomText(
                    text: 'Log Out',
                    fontSize: 22,
                    textColor: Colors.redAccent.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CustomSpacing(height: .02),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDrawerItems extends StatelessWidget {
  const CustomDrawerItems({
    super.key,
    required this.text,
    this.onTap,
  });
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalSpace(context, .002)),
      child: InkWell(
        onTap: onTap,
        focusColor: Colors.grey.shade400,
        child: Container(
          color: Colors.grey.shade200,
          height: verticalSpace(context, .05),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomText(
                text: text,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                textColor: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
