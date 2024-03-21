import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_dish_app/screens/home/cards/restaurantsRectangleCard.dart';
import 'package:hello_dish_app/screens/home/controller/homeController.dart';
import 'package:hello_dish_app/screens/home/ui/address_list_screen.dart';
import 'package:hello_dish_app/screens/home/ui/resturant/notification_screen.dart';
import 'package:hello_dish_app/utilities/app_color.dart';
import 'package:hello_dish_app/utilities/shared_pref..dart';
import 'package:hello_dish_app/utilities/sizedBox.dart';
import 'package:hello_dish_app/utilities/title.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utilities/mediaQuery.dart';
import '../cards/cuisineCard.dart';
import '../cards/restaurantsCard.dart';
import '../models/homeModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController(), permanent: true);

  @override
  void initState() {
    super.initState();
    SharedPref.shared.getPref();

    controller.getCurrentLoc(context);
    callApi();
  }

  callApi() async {
    controller.getHomeDetails();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(SharedPref.shared.pref!.getString(PrefKeys.token));

    List<SubCategoryItem> subCategoryItems = controller.subCategoryList;

    String getImage(String category) {
      switch (category.toLowerCase()) {
        case 'good for breakfast':
          return 'https://media-assets.swiggy.com/swiggy/image/upload/f_auto,q_auto,fl_lossy/xyuu2wdu9l2pnj83ka3m';
        case 'delicious in punjabi':
          return 'https://m.economictimes.com/thumb/msid-71121981,width-1200,height-900,resizemode-4,imgsize-810723/butter-chicken-1.jpg';
        case 'enjoyable in gujrati':
          return 'https://img.veenaworld.com/wp-content/uploads/2023/04/Fall-in-Love-with-Gujarati-Cuisine-A-Bucket-List-of-17-Foods-to-Try-on-Your-Trip-scaled-e1681363124476.webp';
        case 'pleasant in chicken':
          return 'https://m.recipes.timesofindia.com/photo/62711151.cms';
        case 'satisfying in chinese':
          return 'https://www.fryingpanadventures.com/wp-content/uploads/2020/10/image-137-scaled-e1604152201367.jpeg';
        case 'delightful in drink':
          return 'https://www.acouplecooks.com/wp-content/uploads/2021/06/Strawberry-Water-006.jpg';
        case 'heavenly in sweets':
          return 'https://thumbs.dreamstime.com/b/indian-sweets-13868613.jpg';
        case 'sweet in desserts':
          return 'https://cdn.loveandlemons.com/wp-content/uploads/2021/06/summer-desserts.jpg';
        default:
          return '';
      }
    }

    Color getColorForSubCategory(String category) {
      switch (category.toLowerCase()) {
        case 'good for breakfast':
          return AppColors.redGradient;
        case 'delicious in punjabi':
          return AppColors.greenGradient;
        case 'enjoyable in gujrati':
          return AppColors.purpleGradient;
        case 'pleasant in chicken':
          return AppColors.yellowGradient;
        case 'satisfying in chinese':
          return AppColors.greenlightGradient;
        case 'delightful in drink':
          return AppColors.cyanGradient;
        case 'heavenly in sweets':
          return AppColors.orangeGradient;
        case 'sweet in desserts':
          return AppColors.pinkGradient;
        default:
          return Colors.black; // Provide a default color
      }
    }

    String getIcon(String category) {
      switch (category.toLowerCase()) {
        case 'good for breakfast':
          return '🍞';
        case 'delicious in punjabi':
          return '🥘';
        case 'enjoyable in gujrati':
          return '🥘';
        case 'pleasant in chicken':
          return '🍗';
        case 'satisfying in chinese':
          return '🥘';
        case 'delightful in drink':
          return '🍹';
        case 'heavenly in sweets':
          return '🍩';
        case 'sweet in desserts':
          return '🍨';
        default:
          return '';
      }
    }

    return GetBuilder<HomeController>(
        builder: (c) => Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      Get.to(const NotificationScreen());
                    },
                    icon: Icon(Iconsax.notification),
                  )
                ],
                title: GestureDetector(
                  onTap: () {
                    Get.to(const AddressListScreen());
                  },
                  child: Column(
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
                ),
                // actions: [const Icon(Iconsax.notification).paddingAll(18.0)]
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///

                    CarouselSlider.builder(
                      itemCount: controller.offersList.length,
                      itemBuilder: (
                        BuildContext context,
                        int itemIndex,
                        int pageViewIndex,
                      ) =>
                          ClipRRect(
                        borderRadius: BorderRadius.circular(22.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(22.0)),
                          width: double.infinity,
                          child: Image.network(
                            'https://cdn.grabon.in/gograbon/images/merchant/1610000375685.png',
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return Image.network(
                                'https://api.hellodish.in/${controller.offersList[itemIndex].image}', // URL of the alternative image
                                fit: BoxFit.cover,
                                height: SizeConfig.Height * 0.09,
                                width: SizeConfig.Width * 0.18,
                              );
                              // return const Center(
                              //   child: Column(
                              //     children: [
                              //       Icon(Iconsax.danger),
                              //       Text(
                              //         "Image not available",
                              //         textAlign: TextAlign.center,
                              //         maxLines: 2,
                              //       )
                              //     ],
                              //   ),
                              // );
                            },
                            fit: BoxFit.cover,
                            height: SizeConfig.Height * 0.09,
                            width: SizeConfig.Width * 0.18,
                          ),
                          //  Image.network(
                          //   '${c.offersData[itemIndex].image}',
                          //   fit: BoxFit.fill,
                          // ),
                        ),
                      ),
                      options: CarouselOptions(
                        autoPlay: true,
                        enableInfiniteScroll: true,
                        viewportFraction: 0.9,
                        enlargeFactor: 0.18,
                        disableCenter: true,
                        enlargeCenterPage: true,
                        height: SizeConfig.Height * 0.16,
                      ),
                    ).paddingOnly(bottom: 30.0, top: 18.0),

                    ///
                    // Text(
                    //   "What u have craving for ?",
                    //   style: GoogleFonts.poppins(
                    //       fontSize: 20.0, fontWeight: FontWeight.w500),
                    // ).paddingOnly(left: 18.0, bottom: 18.0),
                    // SizedBox(
                    //   width: SizeConfig.Width * 5,
                    //   height: SizeConfig.Height * 0.3,
                    //   child: foodCategoriesCard(),
                    // ),
                    // customTitle(
                    //         title: "Food",
                    //         subtitle: "Popular",
                    //         rSubtitle: " ",
                    //         rTitle: " ")
                    //     .paddingOnly(left: 18.0),
                    // SizedBox(
                    //   width: SizeConfig.Width * 5,
                    //   height: SizeConfig.Height * 0.24,
                    //   child: popularFoodsCard(),
                    // ),
                    customTitle(
                            title: "Restaurant",
                            subtitle: "Popular",
                            rSubtitle: " ",
                            rTitle: " ")
                        .paddingOnly(left: 18.0),
                    SizedBox(
                      width: SizeConfig.Width * 5,
                      height: SizeConfig.Height * 0.3,
                      child: RestaurantsCard(
                          Restaurants: controller.popularRestaurantList),
                    ),
                    //
                    boxA3(),
                    Column(
                      children: subCategoryItems
                          .where((subCategoryItem) =>
                              subCategoryItem.restaurants.isNotEmpty)
                          .map((subCategoryItem) {
                        return SizedBox(
                          height: SizeConfig.Height * 0.36,
                          child: cuisinesCard(
                            cuisineTitle:
                                '${subCategoryItem.subCategory.name}  ${getIcon(subCategoryItem.subCategory.name)}',
                            img: getImage(subCategoryItem.subCategory.name),
                            color: getColorForSubCategory(
                                subCategoryItem.subCategory.name),
                            restaurants: subCategoryItem.restaurants,
                          ),
                        );
                      }).toList(),
                    ),

                    // SizedBox(
                    //   height: SizeConfig.Height * 0.36,
                    //   child: cuisinesCard(
                    //       cuisineTitle: "Good For Breakfast 🍞",
                    //       img:
                    //           'https://media-assets.swiggy.com/swiggy/image/upload/f_auto,q_auto,fl_lossy/xyuu2wdu9l2pnj83ka3m',
                    //       color: AppColors.redGradient)
                    // ),
                    // SizedBox(
                    //   height: SizeConfig.Height * 0.36,
                    //   child: cuisinesCard(
                    //       cuisineTitle: "Delicious in Punjabi  🥘",
                    //       img:
                    //           'https://m.economictimes.com/thumb/msid-71121981,width-1200,height-900,resizemode-4,imgsize-810723/butter-chicken-1.jpg',
                    //       color: AppColors.greenGradient),
                    // ),
                    // SizedBox(
                    //   height: SizeConfig.Height * 0.36,
                    //   child: cuisinesCard(
                    //       cuisineTitle: "Enjoyable in Gujrati  🥘",
                    //       img:
                    //           'https://img.veenaworld.com/wp-content/uploads/2023/04/Fall-in-Love-with-Gujarati-Cuisine-A-Bucket-List-of-17-Foods-to-Try-on-Your-Trip-scaled-e1681363124476.webp',
                    //       color: AppColors.purpleGradient),
                    // ),
                    // SizedBox(
                    //   height: SizeConfig.Height * 0.36,
                    //   child: cuisinesCard(
                    //       cuisineTitle: "Pleasant in Chicken  🍗",
                    //       img:
                    //           'https://m.recipes.timesofindia.com/photo/62711151.cms',
                    //       color: AppColors.yellowGradient),
                    // ),
                    // SizedBox(
                    //   height: SizeConfig.Height * 0.36,
                    //   child: cuisinesCard(
                    //       cuisineTitle: "Satisfying in Chinese  🥘",
                    //       img:
                    //           'https://www.fryingpanadventures.com/wp-content/uploads/2020/10/image-137-scaled-e1604152201367.jpeg',
                    //       color: AppColors.greenlightGradient),
                    // ),
                    // SizedBox(
                    //   height: SizeConfig.Height * 0.36,
                    //   child: cuisinesCard(
                    //       cuisineTitle: "Delightful in drink  🍹",
                    //       img:
                    //           'https://www.acouplecooks.com/wp-content/uploads/2021/06/Strawberry-Water-006.jpg',
                    //       color: AppColors.cyanGradient),
                    // ),
                    // SizedBox(
                    //   height: SizeConfig.Height * 0.36,
                    //   child: cuisinesCard(
                    //       cuisineTitle: "Heavenly in Sweets 🍩",
                    //       img:
                    //           'https://thumbs.dreamstime.com/b/indian-sweets-13868613.jpg',
                    //       color: AppColors.orangeGradient),
                    // ),
                    // SizedBox(
                    //   height: SizeConfig.Height * 0.33,
                    //   child: cuisinesCard(
                    //       cuisineTitle: "Sweet in Dessert 🍨",
                    //       img:
                    //           'https://cdn.loveandlemons.com/wp-content/uploads/2021/06/summer-desserts.jpg',
                    //       color: AppColors.pinkGradient),
                    // ),

                    customTitle(
                            title: "NearBy",
                            subtitle: "Restaurant",
                            rSubtitle: " ",
                            rTitle: " ")
                        .paddingOnly(left: 18.0),
                    SizedBox(
                      width: SizeConfig.Width * 5,
                      // height: SizeConfig.Height * 0.3,
                      child: restaurantsRectangleCard(
                          controller.nearByRestaurantList),
                    ),
                    //
                    boxA3()
                  ],
                ),
                // ).paddingAll(18.0),
              ),
            ));
  }
}
