import 'package:flutter/material.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import 'package:user_boder/global/global.dart';

class RateDriverScreen extends StatefulWidget {

  final String? assignedDriverId;

  const RateDriverScreen({super.key, this.assignedDriverId});

  @override
  State<RateDriverScreen> createState() => _RateDriverScreenState();
}

class _RateDriverScreenState extends State<RateDriverScreen> {
  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14)
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(
          color: darkTheme ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 22,),

            Text("Rate Trip Experience", 
              style: TextStyle(
                fontSize: 22,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
                color: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),
              ),
            ),
            
            const SizedBox(height: 20,),
            
            Divider(thickness: 2,color: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),),
            
            const SizedBox(height: 20,),
            
            SmoothStarRating(
              rating: countRatingStars,
              allowHalfRating: false,
              starCount: 5,
              color: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),
              borderColor: darkTheme ? const Color(0xFF0E9EDC) : Colors.grey,
              size: 46,
              onRatingChanged: (valueOfStarsChoosed){
                countRatingStars = valueOfStarsChoosed;
                
                if(countRatingStars == 1){
                  setState(() {
                    titleStarsRating = "Very Bad";
                  });
                }
                if(countRatingStars == 2){
                  setState(() {
                    titleStarsRating = "Bad";
                  });
                }
                if(countRatingStars == 3){
                  setState(() {
                    titleStarsRating = "Good";
                  });
                }
                if(countRatingStars == 4){
                  setState(() {
                    titleStarsRating = "Very Good";
                  });
                }
                if(countRatingStars == 5){
                  setState(() {
                    titleStarsRating = "Excellent";
                  });
                }
              },
            ),
            
            const SizedBox(height: 10,),
            
            Text(
              titleStarsRating,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),
              ),
            ),
            
            const SizedBox(height: 20,),
            
            ElevatedButton(
              onPressed: () {
                // DatabaseReference rateDriverRef = FirebaseDatabase.instance.ref()
                //     .child("drivers")
                //     .child(widget.assignedDriverId!)
                //     .child("ratings");

                // rateDriverRef.once().then((snap){
                //   if(snap.snapshot.value == null){
                //     rateDriverRef.set(countRatingStars.toString());

                //     Navigator.pop(context);
                //     SystemNavigator.pop();
                //     //Get.to(() => SplashScreen()));
                //   }
                //   else {
                //     double pastRatings = double.parse(snap.snapshot.value.toString());
                //     double newAverageRatings = (pastRatings + countRatingStars)/ 2;
                //     rateDriverRef.set(newAverageRatings.toString());

                //     Navigator.pop(context);
                //     SystemNavigator.pop();
                //     //Get.to(() => SplashScreen()));
                //   }
                //   Fluttertoast.showToast(msg: "Closing the app now");
                // });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),
                padding: const EdgeInsets.symmetric(horizontal: 70),
              ),
              child: Text("Submit",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: darkTheme ? Colors.black : Colors.white,
                ),
              )
            ),
            
          ],
        ),
      ),
    );
  }
}


















