import 'package:get/get.dart';
import 'package:hello_dish_app/utilities/shared_pref..dart';

class RestaurantController extends GetxController {
  RxString name = "".obs;
  RxString area = "".obs;

  @override
  Future<void> onInit() async {
    name.value = SharedPref.shared.pref!.getString(PrefKeys.areaName)!;
    area.value = SharedPref.shared.pref!.getString(PrefKeys.localityName)!;
    update();
  }
}
