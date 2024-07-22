import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

class PaymentPlan extends StatelessWidget {
  const PaymentPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context)=>PaypalCheckout(
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
                  print("Transaction complited: $params");
                  // );
                },
                onError: (error) {
                  print("onError: $error");
                  Navigator.pop(context);
                },
                onCancel: () {
                  print('cancelled:');
                },
              ),
            ));
          },
            child: Text(
              "Paypal"
           )
         ),
        )
      ),
    );
  }
}