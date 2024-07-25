// ignore_for_file: prefer_const_constructors, prefer_if_null_operators

import 'package:bodae/Constants/colors.dart';
import 'package:bodae/payment/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPopUp extends StatefulWidget {
  const PaymentPopUp({super.key});

  @override
  State<PaymentPopUp> createState() => _PaymentPopUpState();
}

class _PaymentPopUpState extends State<PaymentPopUp> {
  final PaymentController paymentController = Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Select Mode of Payment",
            style: TextStyle(
              color: AppColor.blue,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.cancel_outlined,
              size: 24,
              color: AppColor.blue,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GridContent(
                    onTap: paymentController.mpesaCheckout,
                    image: Image.asset("images/mpesa.png")),
                GridContent(
                    onTap: paymentController.paypalCheckout, data: "PayPal")
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GridContent(data: "Cash"),
                GridContent(image: Image.asset("images/airtel.png")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GridContent extends StatelessWidget {
  final String? data;
  final Image? image;
  final VoidCallback? onTap;

  GridContent({super.key, this.data, this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:
            const EdgeInsets.all(2.0), // Increased padding for better spacing
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius:
                BorderRadius.circular(8), // Slightly larger border radius
            boxShadow: [
              BoxShadow(
                blurRadius: 2, // Increased blur radius for more visible shadow
                color: Colors.grey.withOpacity(0.5),
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: image != null
                ? image
                : Text(
                    data ?? "Loading",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18, // Increased font size for better visibility
                      color: AppColor.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
