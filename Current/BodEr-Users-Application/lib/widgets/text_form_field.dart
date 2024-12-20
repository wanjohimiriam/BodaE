import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_boder/widgets/text.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.darkTheme, 
    required this.label, 
    this.prefixIcon, 
    this.validator, 
    this.obsecureText, 
    this.maxLength, 
    this.suffixIcon, 
    this.keyboardType, 
    this.textCapitalization, 
    this.focusNode, 
    this.onEditingComplete, this.hintText,
  });

  final TextEditingController controller;
  final bool darkTheme;
  final bool? obsecureText;
  final String label;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final int? maxLength;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength ?? 100)
      ],
      controller: controller,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      obscureText: obsecureText ?? false,
      style: TextStyle(
        fontSize: 15,
        color: darkTheme ? Colors.white : Colors.grey.shade900,
      ),
      textCapitalization: textCapitalization ?? TextCapitalization.sentences,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        label: CustomText(
          text: label, 
          fontSize: 12, 
          textColor: darkTheme ? Colors.grey.shade200 : Colors.grey.shade700,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
        filled: true,
        fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          )
        ),
        prefixIcon: prefixIcon ?? const Padding(padding: EdgeInsets.only(left: 20)),
        suffixIcon: suffixIcon,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
    );
  }
}