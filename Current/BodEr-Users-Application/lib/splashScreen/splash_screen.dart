
// ignore_for_file: prefer_const_constructors, unused_import, sized_box_for_whitespace

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_boder/screens/languagePop.dart';
import 'package:user_boder/widgets/colors.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? _devWidth, _devHeight;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startProgress();
  }

  void _startProgress() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (progress >= 1) {
        timer.cancel();
        _navigateToLoginPage();
      } else {
        setState(() {
          progress += 0.02;
        });

        if (progress >= 0.5 && progress < 0.52) {
          _showPopup();
        }
      }
    });
  }

  
  void _showPopup() {
    showDialog(
     context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LanguagePopUp(
          onLanguageSelected: () {
            // Navigator.of(context).pop();
            _navigateToLoginPage();
          },
        );
      },
    );
  }
  void _navigateToLoginPage() {
   Get.toNamed("/login");
  }
  // void _navigateToHomePage() {
  //   Get.offNamed('/home'); // Using GetX for navigation
  // }

  @override
  Widget build(BuildContext context) {
    _devHeight = MediaQuery.of(context).size.height;
    _devWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: _devHeight! * 0.15,
              width: _devWidth! * 0.3,
              child: Image.asset(
                "images/bikebodar.png",
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: _devHeight! * 0.09,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 5,
                color: AppColor.white,
                borderRadius: BorderRadius.circular(10),
                backgroundColor: AppColor.blue,
                semanticsLabel: 'Linear progress indicator',
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:get/get.dart';
// import 'package:user_boder/global/global.dart';
// import 'package:user_boder/screens/login_screen.dart';
// import 'package:user_boder/screens/main_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {

//   startTimer() async {
//     if(firebaseAuth.currentUser != null){
//       Timer(const Duration(seconds: 5), () {
//         Get.off(() => const MainScreen());
//       });
//     }
//     else{
//       Timer(const Duration(seconds: 5), () {
//         Get.off(() => LoginScreen());
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Transform.scale(
//           scale: .4,
//           child: Image(
//             image: AssetImage("images/bodanative.png"),
//           ).animate(
//             effects: [
//               FadeEffect(
//                 begin: .3,
//                 end: 1,
//                 duration: const Duration(seconds: 3),
//                 delay: const Duration(seconds: 1),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
