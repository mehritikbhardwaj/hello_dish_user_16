import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_dish_app/screens/cart/ui/cartCompleteScreen.dart';
import 'package:hello_dish_app/screens/restaurant/controller/restaurantController.dart';
import 'package:hello_dish_app/utilities/app_color.dart';
import 'package:hello_dish_app/utilities/shared_pref..dart';
import 'package:hello_dish_app/utilities/sizedBox.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utilities/mediaQuery.dart';
import '../../../utilities/title.dart';
import '../../home/cards/popularFoodCard.dart';
import '../../home/cards/restaurantsCard.dart';
import '../../home/cards/restaurantsRectangleCard.dart';
import '../../home/controller/homeController.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final RestaurantController controller =
      Get.put(RestaurantController(), permanent: true);
  final HomeController homeController =
      Get.put(HomeController(), permanent: true);

  @override
  void initState() {
    super.initState();
    SharedPref.shared.getPref();
  }

  bool onTapFavorite(bool currentIsFavorited) {
    // Toggle the boolean value
    bool newIsFavorited = !currentIsFavorited;

    // Update the state or perform any other necessary actions if needed

    // Return the new boolean value
    return newIsFavorited;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantController>(
        builder: (c) => Scaffold(
              appBar: AppBar(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            controller.name.value,
                            style: GoogleFonts.poppins(
                              fontSize: 18.0,
                            ),
                          ),
                          const Icon(
                            Iconsax.arrow_down_1,
                            size: 16.0,
                          ).paddingOnly(left: 6.0)
                        ],
                      ),
                      Text(
                        controller.area.value,
                        style: GoogleFonts.poppins(
                          fontSize: 12.0,
                        ),
                      ).paddingOnly(top: 3.0),
                    ],
                  ),
                  actions: [const Icon(Iconsax.notification).paddingAll(18.0)]),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: AppColors.theme),
                              borderRadius: BorderRadius.circular(36.0)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(36.0),
                          ),
                          prefixIcon: const InkWell(
                            child: Icon(
                              Iconsax.search_normal,
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(12.0),
                          hintText: 'Search food, Restaurant, Dish',
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 14.0, color: AppColors.grey)),
                      onChanged: (string) {},
                    ).paddingAll(18.0),
                    customTitle(
                            title: "Popular",
                            subtitle: "Food",
                            rSubtitle: " ",
                            rTitle: " ")
                        .paddingOnly(left: 18.0),
                    SizedBox(
                      width: SizeConfig.Width * 5,
                      height: SizeConfig.Height * 0.24,
                      child: popularFoodsCard(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(CartCompleteScreen());
                      },
                      child: customTitle(
                              title: "New added",
                              subtitle: "Fod",
                              rSubtitle: " ",
                              rTitle: " ")
                          .paddingOnly(left: 18.0),
                    ),
                    SizedBox(
                      width: SizeConfig.Width * 5,
                      height: SizeConfig.Height * 0.24,
                      child: popularFoodsCard(),
                    ),
                    customTitle(
                            title: "Popular",
                            subtitle: "Restaurant",
                            rSubtitle: " ",
                            rTitle: " ")
                        .paddingOnly(left: 18.0),
                    SizedBox(
                      width: SizeConfig.Width * 5,
                      height: SizeConfig.Height * 0.3,
                      child: RestaurantsCard(
                          Restaurants: homeController.popularRestaurantList),
                    ),
                    customTitle(
                            title: "New Arrived",
                            subtitle: "Restaurant",
                            rSubtitle: " ",
                            rTitle: " ")
                        .paddingOnly(left: 18.0),
                    SizedBox(
                      width: SizeConfig.Width * 5,
                      height: SizeConfig.Height * 0.3,
                      child: RestaurantsCard(
                          Restaurants: homeController.popularRestaurantList),
                    ),
                    customTitle(
                            title: "NearBy",
                            subtitle: "Restaurant",
                            rSubtitle: " ",
                            rTitle: " ")
                        .paddingOnly(left: 18.0),
                    SizedBox(
                      width: SizeConfig.Width * 5,
                      child: restaurantsRectangleCard(
                          homeController.nearByRestaurantList),
                    ),
                    customTitle(
                            title: "Reastaurant at your location",
                            subtitle: "400+",
                            rSubtitle: " ",
                            rTitle: " ")
                        .paddingOnly(left: 18.0),
                    SizedBox(
                      width: SizeConfig.Width * 5,
                      child: restaurantsRectangleCard(
                          homeController.nearByRestaurantList),
                    ),
                    //
                    boxA3()
                  ],
                ),
              ),
            ));
  }
}
