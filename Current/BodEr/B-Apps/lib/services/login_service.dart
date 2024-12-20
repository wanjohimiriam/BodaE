import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivers/views/homepage/trip_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:drivers/services/printing.dart';
import 'package:drivers/widgets/text.dart';

class AuthService{
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  static Future<void> signInWithGoogle() async {
    try{
        // Begin sign-in process
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      String email = googleUser!.email;
      List users = await firebaseFirestore.collection('drivers').get().then((value) => value.docs);
      if(users.where((item) => item['email'] == email).toList().isEmpty){
        Get.snackbar(
          "Error!!!",
          'No user is recorded under this email address.'
        );
        return;
      }

      // Obtain auth request from request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create new credential for user
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Finally sign in
      await FirebaseAuth.instance.signInWithCredential(credential);
      await Get.off(() => TripStatus());
    } on PlatformException catch(e){
      Printing.print(e.toString());
      Get.dialog(
        AlertDialog(
          title: CustomText(
            text: "Alert!!! ${e.code}", 
            fontSize: 16, 
            textColor: Colors.grey.shade900,
            fontWeight: FontWeight.bold,
          ),
          content: CustomText(
            text: e.message.toString(),
            fontSize: 14, 
            textColor: Colors.grey.shade700,
            fontWeight: FontWeight.normal,
          ),
        ),
        barrierDismissible: true,
      );
    }
  }
}