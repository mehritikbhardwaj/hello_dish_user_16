import 'package:get/get.dart';

import '../../../utilities/api_manager/apis.dart';
import '../../../utilities/api_manager/http_client.dart';
import '../../home/models/homeModel.dart';
import '../model/orderModel.dart';

class SearchGetController extends GetxController{
  final isNonVeg=0.obs;
  final filter = 'relevance'.obs;
  final times= 0.obs;
  final isVeg= false.obs;
  final isTime= false.obs;
  var nearByRestaurantList = <Datum>[].obs;

  selectedFilter(value){
    filter.value=value;
    print(filter.value);
    update();
  }
  getPureVeg(){
    isNonVeg.value=0;
    isVeg.value=!isVeg.value;
    if(isVeg.value){
      isNonVeg.value=1;
    }else{
      isNonVeg.value=0;
    }
    update();
  }
  getTime(){
    isTime.value=!isTime.value;
    if(isTime.value){
      times.value=1;
    }else{
      times.value=0;
    }
    update();
  }
  putFilters() async{
    final params = {
       'categoryId': '',
       'keyword': '',
       'sortBy': filter.value??'',
       'vegNonVeg': isNonVeg.value.toString(),
       'timing': times.value.toString(),
    };
    print(params);
    final res = await HTTPClient.setFilterItem(APIs.categoryOrders, params);

    nearByRestaurantList.value = res.data;
    update();

  }
}