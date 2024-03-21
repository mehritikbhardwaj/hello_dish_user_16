import 'package:get/get.dart';

import '../../../utilities/api_manager/apis.dart';
import '../../../utilities/api_manager/http_client.dart';
import '../model/cart_order_model.dart';


class CartOrderController extends GetxController{
  Rx<CartOrderModel>? allOrderList;

  getOrderList() async {
    final res = await HTTPClient.getCartOrders(
      APIs.cartOrders
    );
    allOrderList=res.obs;
    update();
  }
}