import 'package:flutter/material.dart';
import 'package:hello_dish_app/utilities/app_color.dart';

class CustomRoundedElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomRoundedElevatedButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: appThemeColor,
        // primary: appThemeColor, // Set your desired button color
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20.0), // Adjust the radius as needed
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Color(0xffFDC4BE)),
        ),
      ),
    );
  }
}
