import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_dish_app/screens/home/dashboard_screen.dart';
import 'package:hello_dish_app/utilities/api_manager/apis.dart';
import 'package:hello_dish_app/utilities/api_manager/http_client.dart';
import 'package:hello_dish_app/utilities/api_manager/parammeters.dart';
import 'package:hello_dish_app/utilities/shared_pref..dart';
import 'package:hello_dish_app/utilities/utils.dart';

class LoginController extends GetxController {
  RxBool isVisible = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  loginFunction() async {
    isLoading = true.obs;
    update();
    if (!emailController.text.isEmail &&
        !emailController.text.isPhoneNumber &&
        emailController.text.trim().isEmpty) {
      Utils.showAlertDialog("Invalid Email");
      return false;
    } else if (passwordController.text.toString().trim().isEmpty) {
      Utils.showAlertDialog("Invalid Password");

      return false;
    } else {
      final params = {
        Params.key: emailController.text,
        Params.password: passwordController.text,
      };
      final res = await HTTPClient.postRequest(APIs.login, params);
      if (res["success"] == true) {
        SharedPref.shared.pref?.setInt(PrefKeys.isLoggedIn, 1);
        SharedPref.shared.pref?.setString(PrefKeys.token, res["token"]);
        print(SharedPref.shared.pref!.getString(PrefKeys.token)!);

        SharedPref.shared.pref
            ?.setString(PrefKeys.userDetails, jsonEncode(res["user"]));

        Get.offAll(const DashboardScreen());
      } else {
        SharedPref.shared.pref?.setInt(PrefKeys.isLoggedIn, 0);
        // CommonUtil.showAlertDialog(res["status"]);
      }
      isLoading = false.obs;
      update();
    }
  }
}
