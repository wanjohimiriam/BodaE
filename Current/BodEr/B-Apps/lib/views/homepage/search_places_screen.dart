// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:user_boder/controllers/local_map_controller.dart';
// import 'package:user_boder/widgets/space.dart';
// import 'package:user_boder/widgets/text_form_field.dart';

// class SearchPlacesScreen extends StatelessWidget {
//   SearchPlacesScreen({super.key});
//   final LocalMapController localMapController = Get.put(LocalMapController());

//   @override
//   Widget build(BuildContext context) {

//     bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         backgroundColor: darkTheme ? Colors.black : Colors.white,
//         appBar: AppBar(
//           backgroundColor: darkTheme ? const Color(0xFF0E9EDC) : const Color(0xFF0E9EDC),
//           leading: GestureDetector(
//             onTap: () {
//               if(localMapController.sourceController.text != localMapController.sourceInput.value){
//                 Get.back(result: null);
//               } else {
//                 Get.back(result: localMapController.sourceInput.value);
//               }
//             },
//             child: Icon(Icons.arrow_back, color: darkTheme ? Colors.black : Colors.white,),
//           ),
//           title: Text(
//             "Search & Set dropoff location",
//             style: TextStyle(color: darkTheme ? Colors.black : Colors.white),
//           ),
//           elevation: 0.0,
//         ),
//         body: Column(
//           children: [
//             Container(
//               color: darkTheme ? Colors.grey.shade900 : Colors.grey.shade100,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: verticalSpace(context, .015)),
//                 child: Center(
//                   child: SizedBox(
//                     width: horizontalSpace(context, .9),
//                     child: Autocomplete<String>(
//                       fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) => CustomTextFormField(
//                         controller: textEditingController,
//                         focusNode: focusNode,
//                         darkTheme: darkTheme,
//                         prefixIcon: const Icon(
//                           Icons.location_on,
//                         ),
//                         onEditingComplete: onFieldSubmitted,
//                         validator: (value){
//                           return value!.isEmpty ? "Field cannot be empty" : null;
//                         },
//                         label: "Location",
//                         keyboardType: TextInputType.name, 
//                         hintText: "Karatina Town, Kenya",
//                       ),  
//                       optionsBuilder: (textEditingvalue){
//                         localMapController.sourceController.text = textEditingvalue.text;
//                         localMapController.autofilSuggestions(textEditingvalue.text);
//                         if(textEditingvalue.text.isEmpty){
//                           return const Iterable<String>.empty();
//                         } else {
//                           return localMapController.suggestions.where((p0) => p0.toLowerCase().contains(textEditingvalue.text.toLowerCase()));
//                         }
//                       },
//                       // optionsViewBuilder: (context, onSelected, suggestions){
//                       //   return Column(
//                       //     children: [
//                       //       ...List.generate(
//                       //         suggestions.length,
//                       //         (index) => Container(
//                       //           width: horizontalSpace(context, .95),
//                       //           color: darkTheme ? Colors.grey.shade700 : Colors.grey.shade300,
//                       //           child: Padding(
//                       //             padding: const EdgeInsets.all(16.0),
//                       //             child: CustomText(
//                       //               text: suggestions.toList()[index], 
//                       //               fontSize: 14, 
//                       //               textColor: darkTheme ? Colors.grey.shade100 : Colors.grey.shade900,
//                       //               centerText: false,
//                       //             ),
//                       //           ),
//                       //         ),
//                       //       ),
//                       //     ],
//                       //   );
//                       // },
//                       onSelected: (option){
//                         localMapController.sourceInput.value = option;
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





















