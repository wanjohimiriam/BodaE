import "package:flutter/material.dart";

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color textColor;
  final Color? backgroundColor;
  final bool? centerText;
  final TextDecoration? textDecoration;
  const CustomText({
    super.key, required this.text, required this.fontSize, this.fontWeight, required this.textColor, this.backgroundColor, this.centerText, this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: textColor,
        fontWeight: fontWeight ?? FontWeight.normal,
        backgroundColor: backgroundColor ?? Colors.transparent,
        decoration: textDecoration ?? TextDecoration.none,
      ),
      textAlign: centerText == true ? TextAlign.center : TextAlign.left,
    );
  }
}