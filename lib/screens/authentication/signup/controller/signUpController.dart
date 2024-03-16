import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_dish_app/screens/home/dashboard_screen.dart';
import 'package:hello_dish_app/utilities/api_manager/apis.dart';
import 'package:hello_dish_app/utilities/api_manager/http_client.dart';
import 'package:hello_dish_app/utilities/api_manager/parammeters.dart';
import 'package:hello_dish_app/utilities/shared_pref..dart';
import 'package:hello_dish_app/utilities/utils.dart';

class SignupController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool isVisible = false.obs;
  RxBool isVisible1 = false.obs;
  RxBool isLoading = false.obs;

  signUpFunction() async {
    isLoading = true.obs;
    update();

    try {
      if (validate()) {
        final params = {
          Params.name: nameController.text,
          Params.email: emailController.text,
          Params.phone: numberController.text,
          Params.password: passwordController.text,
        };
        final res = await HTTPClient.postRequest(APIs.signup, params);
        if (res["success"] == true) {
          SharedPref.shared.pref?.setInt(PrefKeys.isLoggedIn, 1);
          SharedPref.shared.pref?.setString(PrefKeys.token, res["token"]);
          print(SharedPref.shared.pref!.getString(PrefKeys.token)!);

          SharedPref.shared.pref
              ?.setString(PrefKeys.userDetails, jsonEncode(res["user"]));

          Get.offAll(const DashboardScreen());
        } else {
          SharedPref.shared.pref?.setInt(PrefKeys.isLoggedIn, 0);
          Utils.showAlertDialog(res["message"]);
        }
      }
    } catch (stacktrace, error) {
      print(stacktrace.toString());
      print(error.toString());
    }

    isLoading = false.obs;
    update();
  }

  validate() {
    if (nameController.text.isEmpty) {
      Utils.showAlertDialog("Name can't be empty");
      return false;
    } else if (emailController.text.isEmpty || !emailController.text.isEmail) {
      Utils.showAlertDialog("Email can't be empty or Invalid Email");
      return false;
    } else if (numberController.text.isEmpty ||
        !numberController.text.isPhoneNumber) {
      Utils.showAlertDialog(
        "Number can't be empty or Invalid number",
      );
      return false;
    } else {
      if (passwordController.text != confirmPasswordController.text) {
        Utils.showAlertDialog("Password & confirm password should be same");

        return false;
      }
    }
    return true;
  }
}
