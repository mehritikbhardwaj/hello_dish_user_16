// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_dish_app/screens/authentication/login/model/loginResponseModel.dart';
import 'package:hello_dish_app/screens/environment/controller/environmentController.dart';
import 'package:hello_dish_app/utilities/api_manager/apis.dart';
import 'package:hello_dish_app/utilities/api_manager/http_client.dart';
import 'package:hello_dish_app/utilities/api_manager/parammeters.dart';
import 'package:hello_dish_app/utilities/shared_pref..dart';
import 'package:hello_dish_app/utilities/utils.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  File? profileEditImg;
  final EnvironmentController environmentContr =
      Get.put(EnvironmentController());
  RxBool isLoading = false.obs;
  var token = "";

  @override
  void onInit() {
    super.onInit();
    //  setProfileData();
    // token = SharedPref.shared.pref!.getString(PrefKeys.token)!;
  }

  // setProfileData() {
  //   User user = User.fromJson(
  //       jsonDecode(SharedPref.shared.pref!.getString(PrefKeys.userDetails)!));

  //   nameController.text = user.name;
  //   emailController.text = user.email;
  //   numberController.text = user.phone;
  // }

  editImg() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      profileEditImg = File(pickedFile.path);
    }
    update();
  }

  updateFunction(BuildContext context) async {
    isLoading = true.obs;
    update();

    final params = {
      Params.name: nameController.text,
    };
    final res = await HTTPClient.putRequest(APIs.update, params);
    if (res["success"] == true) {
      SharedPref.shared.pref
          ?.setString(PrefKeys.userDetails, jsonEncode(res["user"]));

      Utils.showAlertDialog(
        res["message"],
      );
      environmentContr.update();
      environmentContr.setProfileData();
      // setProfileData();
    }
    isLoading = false.obs;
    update();
  }
}
