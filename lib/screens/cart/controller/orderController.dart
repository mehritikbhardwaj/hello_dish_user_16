import 'package:get/get.dart';

import '../../../utilities/api_manager/apis.dart';
import '../../../utilities/api_manager/http_client.dart';
import '../model/cart_order_model.dart';

class CartOrderController extends GetxController {
  Rx<CartOrderModel>? allOrderList;
  var readyToPlace = <Datum>[].obs;

  getOrderList() async {
    final res = await HTTPClient.getCartOrders(APIs.cartOrders);
    allOrderList = res.obs;
    readyToPlace.clear();
    for (int i = 0; i < allOrderList!.value.data.length; i++) {
      if (allOrderList!.value.data[i].status == 0) {
        readyToPlace.add(allOrderList!.value.data[i]);
      }
    }
    update();
  }
}
