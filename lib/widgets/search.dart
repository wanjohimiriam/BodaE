// ignore_for_file: prefer_const_constructors

import 'package:bodae/Constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String? placeholder;


  CustomSearchBar({super.key, required this.placeholder});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: CupertinoSearchTextField(
        placeholder: placeholder?? "Search",
        placeholderStyle: TextStyle(fontSize: 16, 
        color: AppColor.white),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Icon(
            Icons.search,
            color: AppColor.white,
            size: 20,
          ),
        ),
        backgroundColor: AppColor.blue,
        suffixIcon: Icon(
          Icons.cancel_outlined,
          color: AppColor.white,
          size: 20,
        ),
      ),
    );
  }
}