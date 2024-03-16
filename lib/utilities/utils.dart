import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_dish_app/utilities/app_color.dart';
import 'package:hello_dish_app/utilities/theme.dart';

class Utils {
  static showAlertDialog(String midleText) {
    Get.defaultDialog(
        title: 'Alert',
        titleStyle: appTheme.textTheme.bodyLarge!
            .copyWith(fontSize: 20, color: AppColors.theme),
        middleText: midleText,
        middleTextStyle: appTheme.textTheme.bodyLarge!.copyWith(fontSize: 18),
        barrierDismissible: false,
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.theme,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                textStyle: appTheme.textTheme.bodyLarge!
                    .copyWith(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Get.back();
              },
              child: Text('OK',
                  style: appTheme.textTheme.bodyLarge!
                      .copyWith(fontSize: 15, color: Colors.white)))
        ],
        contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 20));
  }
}
