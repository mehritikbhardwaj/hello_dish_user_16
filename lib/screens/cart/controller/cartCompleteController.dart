import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_dish_app/screens/cart/model/order_model.dart';
import 'package:hello_dish_app/screens/cart/ui/orderTrackingScreen.dart';
import 'package:hello_dish_app/screens/home/models/homeModel.dart';
import 'package:hello_dish_app/utilities/api_manager/apis.dart';
import 'package:hello_dish_app/utilities/api_manager/http_client.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../home/models/restaurentDetails.dart';

class CartCompleteController extends GetxController {
  RxString paymentType = "prepayment".obs;

  var isLoading = false.obs;

  late Restaurant restaurant;

  Rx<OrderData> orderData = OrderData.fromJson({}).obs;
  var orderPrice = 0;
  List<RestaurantOffer>? restaurantOffer;

  RestaurantOffer? offerApplied;
  late Razorpay _razorpay;
  String transactionId = "";
  @override
  void onInit() {
    // TODO: implement onInit

    restaurant = Get.arguments["restaurant"] as Restaurant;
    restaurantOffer = Get.arguments["offer"] as List<RestaurantOffer>;
    getCartItem();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // orderData = Get.arguments["orderData"] as CreateOrderData;
    super.onInit();
  }

  paymentMethod(String type) async {
    paymentType.value = type;
    update();
  }

  void getCartItem() async {
    final url = "${APIs.getCartItem}${restaurant.id}";
    try {
      isLoading(true);
      try {
        var res = await HTTPClient.getCartItem(url);
        if (res.data != null) {
          orderData(res.data);
          update();
        } else {}
      } catch (stacktrace, error) {
        print(stacktrace.toString());
        print(error.toString());
      }
    } finally {
      isLoading(false);
    }
  }

  void updateOrder(Map param) async {
    const url = APIs.updateOrder;
    try {
      isLoading(true);
      print(param.toString());
      var res = await HTTPClient.updateOrder(url, param);
      if (res.data != null) {
        orderData(res.data);

        if (res.data?.status == 1) {
          Get.to(() => OrderTrackingScreen());
        }
        update();
      } else {}
    } finally {
      isLoading(false);
    }
  }

  void openCheckout(String amount) async {
    var options = {
      'key': 'rzp_test_utxGx5b5MsHgol',
      'amount': amount.toString(),
      'name': 'Hello Dish Driver',
      'description': 'Payment',
      // 'prefill': {
      //   'contact': '+91${PrefKeys..number}914492',
      //   'email': '${PrefKeys.userGlobal.email}'
      // },
      'theme': {
        'backdrop_color':
            '#F7F9FC', // Change this to the background color you want
        'color': "#DB1D1D", // Change this to the color you want
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("SUCCESS:  ${response.paymentId}");
    transactionId = response.paymentId.toString();
    update();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("errror: " + "${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("EXTERNAL_WALLET: " + "${response.walletName}");
  }

  @override
  void onClose() {
    super.onClose();
    _razorpay.clear();
  }
}
