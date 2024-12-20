import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
import 'dart:convert';
import 'package:intl/intl.dart';

String formatTime(int secs) {
  DateTime time = DateTime(0, 0, 0, 0, 0, secs);
  String formatted = "${time.minute} min(s) ${time.second} second(s)";
  return formatted;
}

String formatTimeClock(int secs) {
  DateTime time = DateTime(0, 0, 0, 0, 0, secs);
  String formatted = "${time.minute < 10 ? '0${time.minute}' : time.minute} : ${time.second < 10 ? "0${time.second}" : time.second}";
  return formatted;
}

Future<void> seekMapPermission() async {
  Location location = Location();
  bool enabled = await location.serviceEnabled();
  if(enabled){
    PermissionStatus permissionStatus = await location.hasPermission();
    if(permissionStatus == PermissionStatus.granted || permissionStatus == PermissionStatus.grantedLimited){
      return;
    } else {
      await location.requestPermission();
      seekMapPermission();
    }
  } else {
    await location.changeSettings();
  }
}

Future<void> seekCameraPermission() async {
  permission.PermissionStatus permissionStatus = await permission.Permission.camera.status;
  if(permissionStatus == permission.PermissionStatus.granted || permissionStatus == permission.PermissionStatus.limited){
    return;
  } else {
    await permission.Permission.camera.request();
    seekCameraPermission();
  }
}

String formatPrice(double value) {
  NumberFormat numberFormat = NumberFormat.decimalPatternDigits(
    locale: 'en_us',
    decimalDigits: 2,
  );

  String amount = numberFormat.format(value);
  return amount;
}

String formatDate(String dateTime){
  String monthName = "";
  String suffix = "";
  String month = DateFormat("MMMM").format(DateTime.parse(dateTime));
  String endsWith = DateTime.parse(dateTime).day.toString()[DateTime.parse(dateTime).day.toString().length - 1];
  switch(endsWith){
    case "1":
      suffix = "st";
      break;

    case "2":
      suffix = "nd";
      break;

    case "3":
      suffix = "rd";
      break;

    default:
      suffix = "th";
  }
  monthName = "${DateTime.parse(dateTime).day}$suffix $month ${DateTime.parse(dateTime).year}";
  return monthName;
}

extension DateTimeExtension on DateTime {
  int get weekOfMonth {
    var date = this;
    final firstDayOfTheMonth = DateTime(date.year, date.month, 1);
    int sum = firstDayOfTheMonth.weekday - 1 + date.day;
    if (sum % 7 == 0) {
      return sum ~/ 7;
    } else {
      return sum ~/ 7 + 1;
    }
  }
}

String decryptItem(String data){
  String output = utf8.decode(base64Decode(data));
  return output;
}