


// ignore_for_file: prefer_const_constructors, unused_import, sized_box_for_whitespace

import 'dart:async';
// import 'package:flutter/material.dart';
import 'package:drivers/views/authentication/register_screen.dart';
import 'package:drivers/views/homepage/trip_status.dart';
import 'package:drivers/views/loading/user_status_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class UserStatus extends StatelessWidget {
  UserStatus({super.key});
  final UserStatusViewModel serStatusViewModel = Get.find<UserStatusViewModel>();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshots){
          if(!snapshots.hasData){
            return RegisterScreen();
          } else {
            return TripStatus();
          }
        },
      ),
    );
  }
}