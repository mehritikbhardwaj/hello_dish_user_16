import 'package:flutter/material.dart';

class AppColors {
  static const theme = Color(0xFFDB1D1D);
  static const white = Color(0xFFFFFFFF);
  static const golden = Color(0xFFfdc348);
  static const textWhite = Color(0xFFFFFFFF);
  static const textBlack = Color(0xFF000000);
  static const grey = Color(0xff9B9B9B);
  static const lightGrey = Color.fromARGB(255, 232, 230, 230);
  static const green = Color.fromARGB(255, 91, 170, 115);
  static const greenCart = Color(0xFF6CB587);

  static const dDefaultPadding = 12.0;

  static const Color dAppColorGrey = Color(0xFFF6f6f6);

  static const redGradient = Color(0xffDB1D1D);
  static const greenGradient = Color(0xff618264);
  static const purpleGradient = Color(0xffB198EA);
  static const yellowGradient = Color(0xffD5BC64);
  static const greenlightGradient = Color(0xff64D58D);
  static const cyanGradient = Color(0xff60CBD2);
  static const orangeGradient = Color(0xffE58101);
  static const pinkGradient = Color(0xffDB629A);

  // static const gray = Color.fromARGB(77, 170, 170, 170);
  static const backgroundblueColour = Color(0xffF7F9FC);
  // static const backgroundblueColour = Color(0xffE2ECF3);

  static const postType1 = Color(0xFFFFFDF1);
  static const postType2 = Color(0xFFEFFAFE);

  static Map<int, Color> color = {
    50: const Color.fromRGBO(136, 14, 79, .1),
    100: const Color.fromRGBO(136, 14, 79, .2),
    200: const Color.fromRGBO(136, 14, 79, .3),
    300: const Color.fromRGBO(136, 14, 79, .4),
    400: const Color.fromRGBO(136, 14, 79, .5),
    500: const Color.fromRGBO(136, 14, 79, .6),
    600: const Color.fromRGBO(136, 14, 79, .7),
    700: const Color.fromRGBO(136, 14, 79, .8),
    800: const Color.fromRGBO(136, 14, 79, .9),
    900: const Color.fromRGBO(136, 14, 79, 1),
  };
}

final appThemeColor = MaterialColor(AppColors.theme.value, AppColors.color);
