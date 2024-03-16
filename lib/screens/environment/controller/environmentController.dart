import 'dart:convert';

import 'package:get/get.dart';
import 'package:hello_dish_app/screens/authentication/login/model/loginResponseModel.dart';
import 'package:hello_dish_app/utilities/shared_pref..dart';

class EnvironmentController extends GetxController {
  //late User user;
  RxInt isLoggedIn = 0.obs;

  @override
  void onInit() {
    super.onInit();

    // isLoggedIn.value = SharedPref.shared.pref!.getInt(PrefKeys.isLoggedIn)!;
    // if (isLoggedIn.value == 1) {
    //   setProfileData();
    // }
  }

  setProfileData() {
    // user = User.fromJson(
    //     jsonDecode(SharedPref.shared.pref!.getString(PrefKeys.userDetails)!));
  }
}
