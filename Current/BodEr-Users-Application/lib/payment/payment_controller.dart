// import 'package:flutter/material.dart';
// import 'package:get/get.dart';



// class PaymentController extends GetxController {
//   dynamic transactionInitialisation;

  //paypal
  // void paypalCheckout() {
  //   Get.to(() => PaypalCheckout(
  //     sandboxMode: true,
  //     returnURL: "success.snippetcoder.com",
  //     cancelURL: "cancel.snippetcoder.com",
  //     clientId: "AYQTHLdyv98Nfg-SvjptdN1gO3ZeVGm-pMRRz5KKBOZFZRo7KTTHMeT5WkyPVmLGwDVibXNJGZw2jQ3j",
  //     secretKey: "EPIrjLuPWV3YgxY8vkZISyA8qriTXIqpi3ThNxaEbyQGDWhrWBlax_ZYh6WpnX8Kl6AqjQD7SkNYcUoJ",
  //     transactions: const [
  //       {
  //         "amount": {
  //           "total": '1',
  //           "currency": "USD",
  //           "details": {
  //             "subtotal": '1',
  //             "shipping": '0',
  //             "shipping_discount": 0
  //           }
  //         },
  //         "description": "The payment transaction description.",
  //         "item_list": {
  //           "items": [
  //             {
  //               "name": "Apple",
  //               "quantity": 1,
  //               "price": '1',
  //               "currency": "USD"
  //             },
  //           ],
  //         }
  //       }
  //     ],
  //     note: "Contact us for any questions on your order.",
  //     onSuccess: (Map params) async {
  //       print("Transaction completed: $params");
  //     },
  //     onError: (error) {
  //       print("onError: $error");
  //       Get.back(); 
  //     },
  //     onCancel: () {
  //       print('cancelled:');
  //     },
  //   ));
  // }

  //mpesa

import 'package:flutter/material.dart';
import 'package:get/get.dart';



class PaymentController extends GetxController {
  dynamic transactionInitialisation;
 void mpesaCheckout() async {
  String? phoneNumber = await _getPhoneNumberFromUser();
  if (phoneNumber != null && phoneNumber.isNotEmpty) {
    if (!phoneNumber.startsWith("254") || phoneNumber.length != 12) {
      print("Invalid phone number format");
      return;
    }

    try {
      // Initialize an STK push request
      MpesaStkResponse response = await FlutterMpesaStk.push(
        businessShortCode: "174379", // Lipa na Mpesa paybill/till number
        amount: 2.0, // Amount to charge
        partyA: phoneNumber, // Customer's phone number
        partyB: "174379", // Same as the businessShortCode
        callBackUrl: "https://your-callback-url.com/paymentCallback", // Callback URL
        accountReference: "Bodae", // Reference for the transaction
        transactionDescription: "Ruaka to Nairobi", // Transaction description
        passKey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919", // Passkey
      );

      // Check if the response is successful
      if (response.isSuccessful) {
        print("Transaction successful: ${response.checkoutRequestID}");
      } else {
        print("Transaction failed: ${response.errorMessage}");
      }
    } catch (e) {
      print("Error occurred during STK push: ${e.toString()}");
    }
  } else {
    print("User cancelled the input or entered an invalid phone number");
  }
}



 Future<String?> _getPhoneNumberFromUser() async {
  TextEditingController phoneNumberController = TextEditingController();

  String? phoneNumber = await Get.dialog<String>(
    AlertDialog(
      title: Text('Enter Phone Number'),
      content: TextField(
        controller: phoneNumberController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: '2547XXXXXXXX',
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Get.back(); // Close the dialog without a result
          },
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Get.back(result: phoneNumberController.text); // Close the dialog with the entered phone number
          },
        ),
      ],
    ),
  );

  return phoneNumber;
}

}
