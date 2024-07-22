// import 'package:get/get_state_manager/get_state_manager.dart';
// class Paymentcontroller extends GetxController{
//    payment(){    
//      PaypalCheckout(
//         sandboxMode: true,
//         clientId: "CLIENT_ID",
//         secretKey: "SECRET_KEY",
//         returnURL: "RETURN_URL",
//         cancelURL: "CANCEL_URL",
//         transactions: const [
//             {
//                 "amount": {
//                     "total": '70',
//                     "currency": "USD",
//                     "details": {
//                         "subtotal": '70',
//                         "shipping": '0',
//                         "shipping_discount": 0
//                     }
//                 },
//                 "description": "The payment transaction description.",
//                 "item_list": {
//                     "items": [
//                         {
//                             "name": "Apple",
//                             "quantity": 4,
//                             "price": '5',
//                             "currency": "USD"
//                         },
//                         {
//                             "name": "Pineapple",
//                             "quantity": 5,
//                             "price": '10',
//                             "currency": "USD"
//                         }
//                     ],
//                     // shipping address is Optional
//                     "shipping_address": {
//                         "recipient_name": "Raman Singh",
//                         "line1": "Delhi",
//                         "line2": "",
//                         "city": "Delhi",
//                         "country_code": "IN",
//                         "postal_code": "11001",
//                         "phone": "+00000000",
//                         "state": "Texas"
//                     },
//                 }
//             }
//         ],
//         note: "PAYMENT_NOTE",
//         onSuccess: (Map params) async {
//             print("onSuccess: $params");
//         },
//         onError: (error) {
//             print("onError: $error");
//             Navigator.pop(context);
//         },
//         onCancel: () {
//             print('cancelled:');
//         },
//     ),

// ));
//   }
// }