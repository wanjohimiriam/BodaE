import 'package:flutter/material.dart';

class PayFareAmountDialog extends StatelessWidget {

  final double? fareAmount;

  const PayFareAmountDialog({super.key, this.fareAmount});

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: darkTheme ? Colors.black : const Color(0xFF0E9EDC),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            const SizedBox(height: 20,),

            Text("Fare Amount".toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: darkTheme ? const Color(0xFF0E9EDC) : Colors.white,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20,),

            Divider(
              thickness: 2,
              color: darkTheme ? const Color(0xFF0E9EDC) : Colors.white,
            ),

            const SizedBox(height: 10,),

            Text(
              "৳ $fareAmount",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: darkTheme ? const Color(0xFF0E9EDC) : Colors.white,
                fontSize: 50,
              ),
            ),

            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "This is the total trip fare amount. Please pay it to the driver",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: darkTheme ? const Color(0xFF0E9EDC) : Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkTheme ? const Color(0xFF0E9EDC) : Colors.white,
                ),
                onPressed: () async {
                  // Fluttertoast.showToast(msg: "Cash Paid now you can rate the driver. Please wait.");

                  // await FirebaseDatabase.instance.ref("user_boder").child(userModelCurrentInfo!.id!).child("rVehicleType").set("none");

                  // await FirebaseDatabase.instance.ref("user_boder").child(userModelCurrentInfo!.id!).child("rid").set("free");

                  // Future.delayed(const Duration(milliseconds: 5000), (){
                  //   Navigator.pop(context, "Cash Paid");
                  //   // SystemNavigator.pop();
                  //   Get.to(() => const SplashScreen());
                  // });
                },
                child: Row(
                  mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pay Cash",
                      style: TextStyle(
                        fontSize: 20,
                        color: darkTheme ? Colors.black : const Color(0xFF0E9EDC),
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "৳ $fareAmount",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: darkTheme ? Colors.black : const Color(0xFF0E9EDC),
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height:  10),

          ],
        ),
      ),
    );
  }
}


















