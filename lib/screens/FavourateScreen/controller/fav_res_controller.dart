import 'package:get/get.dart';

import '../../../utilities/api_manager/apis.dart';
import '../../../utilities/api_manager/http_client.dart';
import '../models/fav_res_model.dart';

class FavResContropller extends GetxController{
  final restList = <Datum>[].obs;
  getFavRes()async{
    final res = await HTTPClient.getFavRest(APIs.favRestaurant);
    print(res.toString());
    restList.value= res.data;
    update();
  }
}