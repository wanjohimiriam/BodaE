import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SplashScreenViewModel extends GetxController with GetSingleTickerProviderStateMixin{
  AnimationController? animationController;

  Future<void> navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    animationController!.dispose();
    Get.offNamed('/userStatus');
  }

  @override
  void onInit() {
    animationController = AnimationController(vsync: this);
    navigateToNext();
    super.onInit();
  }
}