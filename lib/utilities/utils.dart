import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_dish_app/utilities/app_color.dart';
import 'package:hello_dish_app/utilities/theme.dart';

class Utils {
  static showAlertDialog(String midleText) {
    Get.rawSnackbar(
      title: midleText,
      message: " ",
      duration: const Duration(seconds: 3),
    );
  }
}
