import 'package:bodae/payment/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class PaymentPlan extends StatelessWidget {
PaymentPlan({super.key});
final PaymentController paymentController = Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                 paymentController.paypalCheckout();
               },
                child: Text(
                  "Paypal",
                  style: TextStyle(
                    color: Colors.white
                  ),
               ),
               style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
               ),
              ),
              ElevatedButton(
                onPressed: () {
                 // paymentController.mpesaCheckout();
               },
                child: Text(
                  "M-pesa",
                  style: TextStyle(
                    color: Colors.white
                  ),
               ),
               style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
               ),
              ),
            ],
          ),
        )
      ),
    );
  }
}