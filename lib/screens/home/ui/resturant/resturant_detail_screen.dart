// ignore_for_file: prefer_is_empty

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_dish_app/screens/cart/ui/cartCompleteScreen.dart';
import 'package:hello_dish_app/screens/home/controller/resutrant_detail_controller.dart';
import 'package:hello_dish_app/screens/home/models/homeModel.dart';
import 'package:hello_dish_app/screens/home/models/restaurentDetails.dart';
import 'package:hello_dish_app/utilities/api_manager/apis.dart';
import 'package:hello_dish_app/utilities/mediaQuery.dart';
import 'package:hello_dish_app/utilities/shared_pref..dart';
import 'package:hello_dish_app/utilities/utils.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utilities/app_color.dart';
import '../../../../../utilities/const.dart';
import '../../../../../utilities/sizedBox.dart';

class ResturantDetailScreen extends StatefulWidget {
  final Restaurant restaurant;
  const ResturantDetailScreen({super.key, required this.restaurant});

  @override
  State<ResturantDetailScreen> createState() => _ResturantDetailScreenState();
}

class _ResturantDetailScreenState extends State<ResturantDetailScreen> {
  final ResturantDetailController controller =
      Get.put(ResturantDetailController());

  final List<Item> _cartItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final param = {
      "categoryId": "",
      "keyword": "",
      "sortBy": "",
      // "vegNonVeg": 0,
      "timing": 1,
    };
    controller.getCurrentLoc(context);
    controller.getRestDetails(restaurantId: widget.restaurant.id, param: param);
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ResturantDetailController());
    return GetBuilder<ResturantDetailController>(builder: (c) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => Get.back(),
          ),
        ),
        body: controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ListView(
                    children: [
                      customContainer(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.restaurant.restaurantName,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16)),
                                const Icon(Iconsax.heart),
                              ],
                            ),
                            Text(widget.restaurant.restaurantAddress,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500, fontSize: 12)),
                            boxA1(),
                            boxA3(),
                            customDevider(),
                            boxA3(),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 8,
                                      width: 8,
                                      decoration: const BoxDecoration(
                                        color: AppColors.redGradient,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Container(
                                      height: 24,
                                      width: 2,
                                      color: AppColors.redGradient,
                                    ),
                                    Container(
                                      height: 8,
                                      width: 8,
                                      decoration: const BoxDecoration(
                                        color: AppColors.redGradient,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                                boxB1(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Outlet',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                    boxA1(),
                                    Text(
                                      '31 mins',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                boxB1(),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.restaurant
                                                    .restaurantAddress,
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: AppColors.grey),
                                              ),
                                            ],
                                          ),
                                          boxA1(),
                                          Text('Delivery at  🏡 Home',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.grey)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            boxA1(),
                            boxA3(),
                            customDevider(),
                            boxA3(),
                            Container(
                              width: 110,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26),
                                  color: const Color(0xffbfd5b7),
                                  border: Border.all(color: Colors.white)),
                              child: Row(
                                children: [
                                  Text(
                                    '${widget.restaurant.rating} (100)',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textBlack),
                                  ),
                                  boxB1(),
                                  const Icon(
                                    Icons.star,
                                    size: 22,
                                    color: Color(0xff62615f),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 12, vertical: 10),
                      ),
                      boxA3(),
                      controller.restaurantOffer!.isEmpty
                          ? Container()
                          : customDevider(),
                      controller.restaurantOffer!.isEmpty
                          ? Container()
                          : boxA3(),
                      controller.restaurantOffer!.isEmpty
                          ? Container()
                          : Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              height: 60,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.restaurantOffer?.length,
                                itemBuilder: (context, index) {
                                  final item =
                                      controller.restaurantOffer?[index];
                                  return SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl:
                                              "${APIs.base}${item?.image}",
                                          // 'assets/images/offer.png',
                                          height: 60,
                                          width: 70,
                                        ),
                                        boxB3(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('${item?.discount}₹  off',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16)),
                                            Text(
                                                'USE ${item?.offerCode} | ABOVE ₹ ${item?.above}',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12)),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                      controller.restaurantOffer!.isEmpty
                          ? Container()
                          : boxA3(),
                      controller.restaurantOffer!.isEmpty
                          ? Container()
                          : customDevider(),
                      boxA3(),
                      TextField(
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: AppColors.theme),
                                borderRadius: BorderRadius.circular(36.0)),
                            border: InputBorder.none,
                            prefixIcon: const InkWell(
                              child: Icon(
                                Iconsax.search_normal,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(12.0),
                            hintText: 'Search food, Restaurant, Dish',
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 14.0, color: AppColors.grey)),
                        onChanged: (string) {
                          if (string.length > 3 || string.isEmpty) {
                            final param = {
                              "categoryId": "",
                              "keyword": string,
                              "sortBy": "",
                              "timing": 1,
                            };
                            controller.getRestDetails(
                                restaurantId: widget.restaurant.id,
                                param: param);
                          }
                        },
                      ).paddingAll(18.0),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              final param = {
                                "categoryId": "",
                                "keyword": "",
                                "sortBy": "",
                                "vegNonVeg": 0,
                                "timing": 1,
                              };
                              controller.getRestDetails(
                                  restaurantId: widget.restaurant.id,
                                  param: param);
                              c.vegMethod();
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 9.0,
                                  bottom: 9.0,
                                  right: 16.0,
                                  left: 16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: c.iteamveg.value
                                    ? AppColors.backgroundblueColour
                                    : AppColors.theme,
                              ),
                              child: Row(
                                children: [
                                  Text("Veg",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: c.iteamveg.value
                                              ? Colors.black
                                              : Colors.white)),
                                  boxB1(),
                                  !c.iteamveg.value
                                      ? const Icon(
                                          Icons.cancel,
                                          color: Colors.white,
                                          size: 16,
                                        )
                                      : const SizedBox.shrink()
                                ],
                              ),
                            ),
                          ),
                          boxB1(),
                          InkWell(
                            onTap: () {
                              final param = {
                                "categoryId": "",
                                "keyword": "",
                                "sortBy": "",
                                // "vegNonVeg": 0,
                                "timing": 1,
                              };
                              controller.getRestDetails(
                                  restaurantId: widget.restaurant.id,
                                  param: param);
                              c.bestSeller();
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 9.0,
                                  bottom: 9.0,
                                  right: 16.0,
                                  left: 16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: c.iteamBestSellert.value
                                    ? AppColors.backgroundblueColour
                                    : AppColors.theme,
                              ),
                              child: Row(
                                children: [
                                  Text("Bestseller ",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: c.iteamBestSellert.value
                                              ? Colors.black
                                              : Colors.white)),
                                  boxB1(),
                                  !c.iteamBestSellert.value
                                      ? const Icon(
                                          Icons.cancel,
                                          color: Colors.white,
                                          size: 16,
                                        )
                                      : const SizedBox.shrink()
                                ],
                              ),
                            ),
                          ),
                          boxB1(),
                          InkWell(
                            onTap: () {
                              final param = {
                                "categoryId": "",
                                "keyword": "",
                                "sortBy": "",
                                "vegNonVeg": 1,
                                "timing": 1,
                              };
                              controller.getRestDetails(
                                  restaurantId: widget.restaurant.id,
                                  param: param);
                              c.nonVeg();
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 9.0,
                                  bottom: 9.0,
                                  right: 16.0,
                                  left: 16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: c.iteamNonVeg.value
                                    ? AppColors.backgroundblueColour
                                    : AppColors.theme,
                              ),
                              child: Row(
                                children: [
                                  Text("Non veg",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: c.iteamNonVeg.value
                                              ? Colors.black
                                              : Colors.white)),
                                  boxB1(),
                                  !c.iteamNonVeg.value
                                      ? const Icon(
                                          Icons.cancel,
                                          color: Colors.white,
                                          size: 16,
                                        )
                                      : const SizedBox.shrink()
                                ],
                              ),
                            ),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 12),
                      boxA3(),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: c.foodMenu.length,
                        itemBuilder: (context, index) {
                          final itemGroup = c.foodMenu[index];
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    itemGroup.isExpanded =
                                        !itemGroup.isExpanded;
                                  });
                                  // controller.update();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 24),
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          '${itemGroup.meal.name} (${itemGroup.itemLength})',
                                          style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600)),
                                      Image.asset(
                                        'assets/images/arrow-down.png',
                                        height: 30,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              boxA3(),
                              (itemGroup.isExpanded)
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: itemGroup.items.length,
                                      itemBuilder: (context, index) {
                                        final item = itemGroup.items[index];
                                        return order(item);
                                      })
                                  : const SizedBox.shrink(),
                            ],
                          );
                        },
                      ),
                      boxA3(),
                      boxA3(),
                      boxA3(),
                      boxA3(),
                    ],
                  ),
                  if (_cartItems.isNotEmpty &&
                      _cartItems.every((element) => element.quantity > 0))
                    _viewCartWidget(
                      itemCount: _cartItems.length,
                      onTap: () {
                        // final orderPrice = _cartItems
                        //     .map((e) => e.price)
                        //     .reduce((value, element) => value + element);

                        int orderPrice = 0;
                        var orderItems = [{}];

                        for (var e in _cartItems) {
                          final itemName = e.name;
                          final quantity = e.quantity;
                          final image = e.image;
                          final price = e.price;

                          orderItems.add({
                            "item": itemName,
                            "quantity": quantity,
                            "image": image,
                            "price": price,
                          });
                          orderPrice = orderPrice + (quantity * price);
                        }

                        var selectedId = SharedPref.shared.pref!
                                .getString("primaryLocationId") ??
                            "";

                        orderItems
                            .removeWhere((element) => element.keys.length <= 0);

                        print("orderItems: $orderItems");

                        if (selectedId == "") {
                          Utils.showAlertDialog(
                              "Please add a primary location");
                        } else {
                          final params = {
                            "paymentType": "cod", //prepayment
                            "orderPrice": orderPrice,
                            "orderItems": orderItems,
                            "restaurantId": widget.restaurant.id,
                            "customerLocationId": selectedId,
                            "lat": double.parse(
                                controller.latitude.value.toString()),
                            "long": double.parse(
                                controller.longitude.value.toString()),
                            "status": 0,
                            "offer": ""
                          };
                          print("orderItems: $params");
                          controller.createOrder(
                            params,
                            (p0) {
                              Get.to(() => const CartCompleteScreen(),
                                  arguments: {
                                    "items": _cartItems,
                                    "restaurant": widget.restaurant,
                                    "offer": controller.restaurantOffer
                                  });
                            },
                          );
                        }
                      },
                    )
                  else
                    const SizedBox.shrink()
                ],
              ),
      );
    });
  }

  Widget order(Item item) {
    Get.put(btnController());
    return GetBuilder<btnController>(builder: (c) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.green),
                          ),
                        ),
                      ),
                      boxA3(),
                      Text(
                        "Bestseller",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ).paddingOnly(left: 12.0)
                    ],
                  ),
                  boxA2(),
                  Text(item.name,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                  Text("₹ ${item.price}"),
                  boxA2(),
                  Container(
                    width: SizeConfig.Width * 0.27,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        color: const Color(0xffb5eead),
                        border: Border.all(color: Colors.white)),
                    child: Row(
                      children: [
                        Text(
                          '${item.rating} (100)',
                          style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textBlack),
                        ),
                        boxB1(),
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: Color(0xff62615f),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 120,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 2,
                      top: 0,
                      child: SizedBox(
                        height: SizeConfig.Height * 0.16,
                        // width: SizeConfig.Width * 0.18,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22.0),
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: APIs.base + item.image,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Iconsax.user),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white,
                            )),
                        height: 30,
                        width: SizeConfig.Width * 0.18,
                        child: item.quantity > 0
                            ? ElevatedButton(
                                onPressed: () {},
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.green),
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.symmetric(horizontal: 12))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          // c.icreasebtn();
                                          item.quantity += 1;
                                          _cartItems.removeWhere((element) =>
                                              element.id == item.id);
                                          _cartItems.add(item);
                                        });
                                      },
                                      child: Text(
                                        '+',
                                        style: GoogleFonts.poppins(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      item.quantity.toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          item.quantity -= 1;
                                          if (item.quantity == 0) {
                                            _cartItems.removeWhere((element) =>
                                                element.id == item.id);
                                          }
                                        });
                                      },
                                      child: Center(
                                        child: Text(
                                          '-',
                                          style: GoogleFonts.poppins(
                                              fontSize: 22,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    item.quantity += 1;
                                    _cartItems.add(item);
                                  });
                                },
                                child: Text(
                                  "Add",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _viewCartWidget extends StatelessWidget {
  _viewCartWidget({super.key, required this.itemCount, required this.onTap});

  int itemCount;

  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -40),
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
            color: AppColors.greenCart,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$itemCount ITEM ADDED",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.white),
            ),
            InkWell(
              onTap: onTap,
              child: Row(
                children: [
                  Text(
                    "View",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColors.white),
                  ).paddingOnly(right: 8),
                  Image.asset(
                    "assets/images/bag.png",
                    width: 22,
                    color: AppColors.white,
                  )
                ],
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}
