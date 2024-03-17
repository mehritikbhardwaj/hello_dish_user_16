import 'package:get/get.dart';
import 'package:hello_dish_app/screens/cart/model/order_model.dart';
import 'package:hello_dish_app/screens/home/models/homeModel.dart';
import 'package:hello_dish_app/utilities/api_manager/apis.dart';
import 'package:hello_dish_app/utilities/api_manager/http_client.dart';

import '../../home/models/restaurentDetails.dart';

class CartCompleteController extends GetxController {
  RxBool paymentType = false.obs;

  var isLoading = false.obs;

  late Restaurant restaurant;

  Rx<OrderData> orderData = OrderData.fromJson({}).obs;
  var orderPrice = 0;
  List<RestaurantOffer>? restaurantOffer;

  RestaurantOffer? offerApplied;

  @override
  void onInit() {
    // TODO: implement onInit

    restaurant = Get.arguments["restaurant"] as Restaurant;
    restaurantOffer = Get.arguments["offer"] as List<RestaurantOffer>;
    // getCartItem();
    // orderData = Get.arguments["orderData"] as CreateOrderData;
    super.onInit();
  }

  paymentMethod() {
    paymentType.value = !paymentType.value;
    update();
  }

  void getCartItem() async {
    final url = "${APIs.getCartItem}${restaurant.id}";
    try {
      isLoading(true);
      var res = await HTTPClient.getCartItem(url);
      if (res.data != null) {
        orderData(res.data?[0]);
        update();
      } else {}
    } finally {
      isLoading(false);
    }
  }

  void updateOrder(Map param) async {
    const url = APIs.updateOrder;
    try {
      isLoading(true);
      var res = await HTTPClient.updateOrder(url, param);
      if (res.data != null) {
        orderData(res.data?[0]);
        update();
      } else {}
    } finally {
      isLoading(false);
    }
  }
}
