// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:bodae/Constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  String? hint;
  final Color? labelcolor;
  final double? height;
  final double? width;
  final String label;
  String? Function(String?)? validator;
  final TextEditingController? controller;
  bool? obsecureText;
  int? maxLines;
  EdgeInsetsGeometry? padding;
  final BorderSide? border;
  final BorderSide? border2;
  List<String>? autofillHints;
  Widget? suffixIcon;
  TextInputType? keyboardType;
  final double? fontSize;
  Widget? prefixIcon;
  EdgeInsetsGeometry? outterPadding;

  CustomTextInput({
    super.key,
    required this.label,
    this.hint,
    this.validator,
    this.controller,
    this.obsecureText,
    this.maxLines,
    this.padding,
    this.autofillHints,
    this.suffixIcon,
    this.keyboardType,
    this.prefixIcon,
    this.outterPadding,
    this.fontSize,
    this.border, this.border2, this.height, this.width, this.labelcolor, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outterPadding ??
          EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.08,
              vertical: MediaQuery.of(context).size.height * 0, ),
      child: Center(
        child: Container(
          height:height,
          width: width,
          child: TextFormField(
            autofillHints: autofillHints,
            validator: validator,
            controller: controller,
            maxLines: maxLines ?? 1,
            obscureText: obsecureText ?? false,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: AppColor.blue,
                  fontSize: 14
                ),
            keyboardType: keyboardType ?? TextInputType.text,
            decoration: InputDecoration(
              //fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColor.blue,
                      // color: primaryColor.withOpacity(.9),
                      width: 1),
                  borderRadius: BorderRadius.circular(6)),
              enabledBorder: OutlineInputBorder(
                borderSide: border2?? BorderSide(
                  color: AppColor.blue,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              border: OutlineInputBorder(
                  borderSide: border ?? BorderSide(color: AppColor.blue, width: 2),
                  borderRadius: BorderRadius.circular(6)),
              labelText: label,
              labelStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: fontSize ?? 16,
                    color: labelcolor?? AppColor.blue,
                  ),
              hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: fontSize ?? 14,
                    color: AppColor.white,
                  ),
              hintText: hint ?? "",
              contentPadding: padding ?? const EdgeInsets.symmetric(horizontal: 10),
              suffixIcon: suffixIcon,
              prefix: prefixIcon,
            ),
          ),
        ),
      ),
    );
  }
}
