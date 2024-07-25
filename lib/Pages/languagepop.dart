import 'package:bodae/Constants/colors.dart';
import 'package:flutter/material.dart';

class LanguagePopUp extends StatefulWidget {
  final VoidCallback onLanguageSelected;

  LanguagePopUp({super.key, required this.onLanguageSelected});

  @override
  State<LanguagePopUp> createState() => _LanguagePopUpState();
}

class _LanguagePopUpState extends State<LanguagePopUp> {
  String? selectedLanguage = "English"; // Default selected language

  void _onLanguageTap(String language) {
    setState(() {
      selectedLanguage = language;
    });
    widget.onLanguageSelected();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Select Language",
            style: TextStyle(
              color: AppColor.blue,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
              fontSize: 17,
            ),
          ),
          SizedBox(
            width: 60,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.cancel_outlined,
              size: 18,
              color: AppColor.blue,
            ),
          ),
        ],
      ),
      content: Container(
        color: AppColor.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _onLanguageTap("English"),
              child: PopRow(
                data: "English",
                backcolor: selectedLanguage == "English"
                    ? AppColor.blue
                    : Color.fromARGB(255, 193, 202, 193),
                isSelected: selectedLanguage == "English",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => _onLanguageTap("Kiswahili"),
              child: PopRow(
                data: "Kiswahili",
                backcolor: selectedLanguage == "Kiswahili"
                    ? AppColor.blue
                    : Color.fromARGB(255, 193, 202, 193),
                isSelected: selectedLanguage == "Kiswahili",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PopRow extends StatelessWidget {
  final String data;
  final Color backcolor;
  final bool isSelected;

  PopRow({
    super.key,
    required this.data,
    required this.isSelected,
    required this.backcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 9,
            backgroundColor: isSelected ? AppColor.blue : Color.fromARGB(255, 193, 202, 193),
            child: isSelected
                ? Icon(Icons.check, size: 12, color: AppColor.white)
                : null,
          ),
          SizedBox(
            height: 30,
            width: 30,
          ),
          Text(
            data,
            style: TextStyle(
              color: AppColor.blue, // Always blue
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
