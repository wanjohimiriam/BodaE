import 'package:get/get.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

class PaymentController extends GetxController {
  dynamic transactionInitialisation;
  //paypal
  void paypalCheckout() {
    Get.to(() => PaypalCheckout(
      sandboxMode: true,
      returnURL: "success.snippetcoder.com",
      cancelURL: "cancel.snippetcoder.com",
      clientId: "AYQTHLdyv98Nfg-SvjptdN1gO3ZeVGm-pMRRz5KKBOZFZRo7KTTHMeT5WkyPVmLGwDVibXNJGZw2jQ3j",
      secretKey: "EPIrjLuPWV3YgxY8vkZISyA8qriTXIqpi3ThNxaEbyQGDWhrWBlax_ZYh6WpnX8Kl6AqjQD7SkNYcUoJ",
      transactions: const [
        {
          "amount": {
            "total": '1',
            "currency": "USD",
            "details": {
              "subtotal": '1',
              "shipping": '0',
              "shipping_discount": 0
            }
          },
          "description": "The payment transaction description.",
          "item_list": {
            "items": [
              {
                "name": "Apple",
                "quantity": 1,
                "price": '1',
                "currency": "USD"
              },
            ],
          }
        }
      ],
      note: "Contact us for any questions on your order.",
      onSuccess: (Map params) async {
        print("Transaction completed: $params");
      },
      onError: (error) {
        print("onError: $error");
        Get.back(); 
      },
      onCancel: () {
        print('cancelled:');
      },
    ));
  }
  //mpesa
  void mpesaCheckout() async{
    try {
      transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: "174379",
        transactionType: TransactionType.CustomerPayBillOnline, 
        amount: 2.0,
        partyA: "254758677690",
        partyB: "174379",
        callBackURL: Uri(
          scheme: "https",
          path: "paymentCallback",
          host: "us-central1-negel-da5d1.cloudfunctions.net",
        ),
        accountReference: "Bodae",
        phoneNumber: "254758677690",
        baseUri: Uri(
          scheme: "https",
          host: "sandbox.safaricom.co.ke"
        ),
        transactionDesc: "Ruaka to Nairobi",
        passKey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919"
        );                      
      } catch (e) { 
       print(e.toString());
      }
  }
}
