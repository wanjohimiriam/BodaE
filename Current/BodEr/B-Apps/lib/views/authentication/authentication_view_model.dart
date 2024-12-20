import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivers/services/login_service.dart';
import 'package:drivers/views/authentication/login_screen.dart';
import 'package:drivers/views/homepage/trip_status.dart';
import 'package:drivers/widgets/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationViewModel extends GetxController{
  AuthenticationViewModel({required this.firebaseAuth});
  final FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgotPasswordKey = GlobalKey<FormState>();

  // Observables
  final RxBool _loading = false.obs;
  final RxBool _obsecureValue = true.obs;

  // Getters
  bool get loading => _loading.value;
  bool get obsecureValue => _obsecureValue.value;

  // Setter
  void toggleVisibility() => _obsecureValue.value = !obsecureValue;

  Future<void> registerUser() async {
    _loading.value = true;
    try{
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email.text.toLowerCase().trim(), 
        password: password.text,
      ).then(
        (value) async {
          await firebaseFirestore.collection('drivers').doc(value.user!.email).set(
            {
              'username': name.text,
              'email': value.user!.email,
              'phone': "+254${phone.text}",
              'address': address.text,
              'image': null,
              'status': 'driver',
              'rating': 0.0,
              'balance': 0.0,
              'documents': {},
            }
          );
        }
      );
      clearControllers();
      _loading.value = false;
      await Get.off(() => TripStatus());
      disposeControllers();
    } on FirebaseAuthException catch(e){
      _loading.value = false;
      switch(e.code){
        case 'email-already-in-use':
          Get.snackbar("Failed!!!", "There already exists an account with the given email address.");
          break;

        case 'invalid-email':
          Get.snackbar("Failed!!!", "The email address is not valid.");
          break;

        case 'operation-not-allowed':
          Get.snackbar("Failed!!!", "E-mail/password accounts are not enabled. Enable email/password accounts in the Firebase Console, under the Auth tab.");
          break;

        default:
          Get.snackbar("Failed!!!", "The password is not strong enough.");
      }
    } catch(e){
      _loading.value = false;
      Get.snackbar(
        "Failed!!!",
        "$e",
      );
    }
  }

  Future<void> loginUser() async {
    _loading.value = true;
    try{
      await firebaseAuth.signInWithEmailAndPassword(
        email: email.text.toLowerCase().trim(), 
        password: password.text,
      );
      clearControllers();
      _loading.value = false;
      await Get.off(() => TripStatus());
      disposeControllers();
    } on FirebaseAuthException catch(e){
      _loading.value = false;
      switch(e.code){
        case 'wrong-password':
          Get.snackbar("Failed!!!", "The password is invalid for the given email, or the account corresponding to the email doesn't have a password set.");
          break;

        case 'invalid-email':
          Get.snackbar("Failed!!!", "Thrown if the email address is not valid.");
          break;

        case 'user-disabled':
          Get.snackbar("Failed!!!", "The user corresponding to the given email has been disabled.");
          break;

        default:
          Get.snackbar("Failed!!!", "Thrown if there is no user corresponding to the given email.");
      }
    } catch(e){
      _loading.value = false;
      Get.snackbar(
        "Failed!!!",
        "$e",
      );
    }
  }

  Future<void> resetPassword(String email) async {
    _loading.value = true;
    try{
      List users = await firebaseFirestore.collection('drivers').get().then((value) => value.docs);
      if(users.where((item) => item['email'] == email).toList().isNotEmpty){
        await firebaseAuth.sendPasswordResetEmail(
          email: email,
        );
      } else {
        Get.snackbar(
          "Error!!!",
          'No user is recorded under this email address.'
        );
      }
      Get.snackbar(
        "Success", 
        'Successfully sent the reset link. Visit email to reset link',
        isDismissible: false,
        duration: const Duration(minutes: 1),
        mainButton: TextButton(
          onPressed: () async {
            Get.back();
            await Get.off(() => LoginScreen());
          },
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: Colors.blue,
          ),
          child: CustomText(
            text: "Done",
            fontSize: 12,
            textColor: Colors.white,
            fontWeight: FontWeight.bold,
          )
        )
      );
      _loading.value = false;
    } catch(e){
      _loading.value = false;
      Get.snackbar(
        "Error!!",
        '$e',
      );
    }
  }

  Future<void> googleSignIn() async {
    _loading.value = true;
    try{
      await AuthService.signInWithGoogle();
      _loading.value = false;
    } catch(e){
      _loading.value = false;
    }
  }
  
  Future<void> signOut() async {
    _loading.value = true;
    await firebaseAuth.signOut();
    await GoogleSignIn().signOut();
    _loading.value = false;
  }

  void disposeControllers(){
    name.dispose();
    email.dispose();
    address.dispose();
    phone.dispose();
    password.dispose();
    confirmPassword.dispose();
  }

  void clearControllers(){
    name.clear();
    email.clear();
    address.clear();
    phone.clear();
    password.clear();
    confirmPassword.clear();
  }
}
