import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hello_dish_app/screens/home/models/locationModel.dart';
import 'package:hello_dish_app/screens/home/models/offersModel.dart';
import 'package:hello_dish_app/utilities/api_manager/apis.dart';
import 'package:hello_dish_app/utilities/shared_pref..dart';

import '../../../utilities/api_manager/http_client.dart';
import '../models/homeModel.dart';

class HomeController extends GetxController {
  RxString latitude = "".obs;
  RxString longitude = "".obs;
  RxString name = "".obs;
  RxString area = "".obs;
  var isLoading = true.obs;

  var locationList = <LocationData>[].obs;
  var offerList = <RestaurantOffer>[].obs;
  var popularRestaurantList = <Restaurant>[].obs;
  var nearByRestaurantList = <Restaurant>[].obs;
  var subCategoryList = <SubCategoryItem>[].obs;
  var offersList = <OfferArray>[].obs;

  void getOffersList() async {
    try {
      isLoading(true);
      var offers = await HTTPClient.getOffersList(APIs.getOffers);
      print(offers.toJson());
      offerList.value = offers.restaurant;
    } finally {
      isLoading(false);
    }
  }

  void getLocationList(String key) async {
    try {
      isLoading(true);
      update();

      var offers =
          await HTTPClient.getLocationnList("${APIs.getLocation}?keyword=$key");
      print(offers.toJson());
      locationList.value = offers.location;
    } finally {
      isLoading(false);
      update();
    }
  }

  void addFav(String restId) async {
    String url = '${APIs.addFav}$restId';
    try {
      isLoading(true);
      var offers = await HTTPClient.getOffersList(APIs.getOffers);
      print(offers.toJson());
      offerList.value = offers.restaurant;
    } finally {
      isLoading(false);
    }
  }

  void getHomeDetails() async {
    try {
      isLoading(true);
      update();
      var homeDetails = await HTTPClient.homeScreen(APIs.home);
      popularRestaurantList.value = homeDetails.data.ratingRestaurantArray;
      nearByRestaurantList.value = homeDetails.data.nearbyRestaurantArray;
      subCategoryList.value = homeDetails.data.subCategoryItems;
      offersList.value = homeDetails.data.offerArray;
      getLocationList("");
    } finally {
      isLoading(false);
      update();
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
    List<Placemark> placemark = await placemarkFromCoordinates(
        double.parse(latitude.value), double.parse(longitude.value),
        localeIdentifier: "en");

    // var stateName =
    //     stateAbbreviationMapFunction(placemark[0].administrativeArea!);

    name.value = placemark[0].locality!;
    area.value = placemark[0].subLocality!;
    SharedPref.shared.pref?.setString(PrefKeys.localityName, area.value);
    SharedPref.shared.pref?.setString(PrefKeys.areaName, name.value);

    update();

    latitude.value = (position.latitude.toString());
    longitude.value = position.longitude.toString();
  }

  String stateAbbreviationMapFunction(String administrativeArea) {
    // Mapping of Indian state abbreviations to full names
    Map<String, String> stateAbbreviationMap = {
      'AP': 'Andhra Pradesh',
      'AR': 'Arunachal Pradesh',
      'AS': 'Assam',
      'BR': 'Bihar',
      'CT': 'Chhattisgarh',
      'GA': 'Goa',
      'GJ': 'Gujarat',
      'HR': 'Haryana',
      'HP': 'Himachal Pradesh',
      'JH': 'Jharkhand',
      'KA': 'Karnataka',
      'KL': 'Kerala',
      'MP': 'Madhya Pradesh',
      'MH': 'Maharashtra',
      'MN': 'Manipur',
      'ML': 'Meghalaya',
      'MZ': 'Mizoram',
      'NL': 'Nagaland',
      'OR': 'Odisha',
      'PB': 'Punjab',
      'RJ': 'Rajasthan',
      'SK': 'Sikkim',
      'TN': 'Tamil Nadu',
      'TG': 'Telangana',
      'TR': 'Tripura',
      'UP': 'Uttar Pradesh',
      'UK': 'Uttarakhand',
      'WB': 'West Bengal',
      'AN': 'Andaman and Nicobar Islands',
      'CH': 'Chandigarh',
      'DN': 'Dadra and Nagar Haveli and Daman and Diu',
      'DL': 'Delhi',
      'JK': 'Jammu and Kashmir',
      'LA': 'Lakshadweep',
      'LD': 'Ladakh',
      'PY': 'Puducherry',
    };

    return stateAbbreviationMap[administrativeArea] ?? 'Unknown';
  }
}
