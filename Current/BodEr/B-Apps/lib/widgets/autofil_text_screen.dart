import 'package:drivers/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AutofillTextFormField extends StatelessWidget {
  const AutofillTextFormField({
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
    this.onEditingComplete,
    this.hintText,
    this.onTapOutside,
    required TextInputType textInputType,
    this.autovalidateMode,
    this.onChanged,
    this.enabled,
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
  final void Function(PointerDownEvent)? onTapOutside;
  final AutovalidateMode? autovalidateMode;
  final void Function(String)? onChanged;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength ?? 100),
        keyboardType == TextInputType.number ? FilteringTextInputFormatter.digitsOnly : FilteringTextInputFormatter.singleLineFormatter,
      ],
      controller: controller,
      focusNode: focusNode,
      enabled: enabled ?? true,
      onEditingComplete: onEditingComplete,
      obscureText: obsecureText ?? false,
      style: TextStyle(
        fontSize: 15,
        color: darkTheme ? Colors.white : Colors.grey.shade900,
      ),
      textCapitalization: textCapitalization ?? TextCapitalization.sentences,
      onTapOutside: onTapOutside,
      keyboardType: keyboardType ?? TextInputType.text,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 15,
        ),
        filled: true,
        fillColor: darkTheme ? Colors.black45 : Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 2,
            style: BorderStyle.none,
            color: AppColor.lightGrey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 2,
            style: BorderStyle.none,
            color: AppColor.lightGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 2,
            style: BorderStyle.none,
            color: AppColor.blue, 
          ),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      validator: validator,
    );
  }
}