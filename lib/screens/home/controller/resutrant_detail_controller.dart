import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../utilities/api_manager/apis.dart';
import '../../../utilities/api_manager/http_client.dart';
import '../models/homeModel.dart';
import '../models/restaurentDetails.dart';

class ResturantDetailController extends GetxController {
  RxBool iteamveg = true.obs;
  RxBool iteamBestSellert = false.obs;
  RxBool iteamNonVeg = true.obs;
  RxBool isStater = false.obs;
  RxBool isMeal = false.obs;
  RxBool isDinner = false.obs;
  RxBool isRecommeded = false.obs;
  RxString latitude = "".obs;
  RxString longitude = "".obs;
  var isLoading = true.obs;
  var restDetails = Restaurant;
  List<ItemWrapper> foodMenu = [];
  List<RestaurantOffer>? restaurantOffer;

  vegMethod() {
    iteamveg.value = !iteamveg.value;
    update();
  }

  bestSeller() {
    iteamBestSellert.value = !iteamBestSellert.value;
    update();
  }

  nonVeg() {
    iteamNonVeg.value = !iteamNonVeg.value;
    update();
  }

  isStaterMethod() {
    isStater.value = !isStater.value;
    update();
  }

  isMealMethod() {
    isMeal.value = !isMeal.value;
    update();
  }

  isDinnerMethod() {
    isDinner.value = !isDinner.value;
    update();
  }

  isRecomMethod() {
    isRecommeded.value = !isRecommeded.value;
    update();
  }

  void getRestDetails(
      {required String restaurantId, required Map param}) async {
    String api = APIs.restDetails +
        (restaurantId != null ? '?restaurantId=$restaurantId' : '');

    try {
      isLoading(true);
      var homeDetails = await HTTPClient.getRestDetails(api, param);
      restaurantOffer = homeDetails.data.restaurantOffer;
      foodMenu = homeDetails.data.item;
      update();
    } finally {
      isLoading(false);
    }
  }

  void createOrder(Map param, Function(bool) completion) async {
    String api = APIs.createOrder;
    try {
      isLoading(true);
      var order = await HTTPClient.createOrder(api, param);
      if (order.status == true) {
        completion(true);
      } else {
        completion(false);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> getCurrentLoc(BuildContext context) async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    latitude.value = position.latitude.toString();
    longitude.value = position.longitude.toString();
  }
}

class btnController extends GetxController {
  RxBool addBtn = false.obs;
  RxInt btnVal = 1.obs;
  btnMethod() {
    addBtn.value = true;
    update();
  }

  icreasebtn() {
    btnVal = btnVal + 1;
  }

  decreseBtn() {
    if (btnVal.value > 1) {
      btnVal = btnVal - 1;
    } else {
      addBtn.value = true;
    }
  }
}
