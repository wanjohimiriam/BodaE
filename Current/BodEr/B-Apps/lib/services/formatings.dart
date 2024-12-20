import 'package:intl/intl.dart';

String formatPrice(double value) {
  NumberFormat numberFormat = NumberFormat.decimalPatternDigits(
    locale: 'en_us',
    decimalDigits: 2,
  );

  String amount = numberFormat.format(value);
  return amount;
}

String formatString(String input){
  return "${input.toUpperCase().substring(0, 1)}${input.substring(1, input.length)}";
}

extension FormatString on String{
  String get format => "${toUpperCase().substring(0, 1)}${substring(1, length)}";
}