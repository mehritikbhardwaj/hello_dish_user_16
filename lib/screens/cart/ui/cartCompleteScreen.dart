// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_dish_app/screens/cart/controller/cartCompleteController.dart';
import 'package:hello_dish_app/screens/cart/model/order_model.dart';
import 'package:hello_dish_app/screens/cart/ui/offerScreen.dart';
import 'package:hello_dish_app/screens/cart/ui/orderTrackingScreen.dart';
import 'package:hello_dish_app/screens/home/controller/resutrant_detail_controller.dart';
import 'package:hello_dish_app/utilities/app_color.dart';
import 'package:hello_dish_app/utilities/const.dart';
import 'package:hello_dish_app/utilities/mediaQuery.dart';
import 'package:hello_dish_app/utilities/shared_pref..dart';
import 'package:hello_dish_app/utilities/sizedBox.dart';
import 'package:hello_dish_app/utilities/utils.dart';
import 'package:iconsax/iconsax.dart';

class CartCompleteScreen extends StatefulWidget {
  const CartCompleteScreen({super.key});

  @override
  State<CartCompleteScreen> createState() => _CartCompleteScreenState();
}

class _CartCompleteScreenState extends State<CartCompleteScreen> {
  final ResturantDetailController controller =
      Get.put(ResturantDetailController());
  final CartCompleteController cartCompleteController =
      Get.put(CartCompleteController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: Obx(
        () => !cartCompleteController.isLoading.value
            ? _bottomPayButton(
                cartCompleteController,
              ).paddingOnly(left: 30.0)
            : Container(),
      ),
      body: Obx(
        () => cartCompleteController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        //  HOTEL AND ORDER CONTAINER
                        cartCompleteController.orderData.value.isBlank != true
                            ? customContainer(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartCompleteController
                                          .restaurant.restaurantName,
                                      style: GoogleFonts.poppins(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    boxA1(),
                                    (cartCompleteController.orderData.value
                                                    .orderItems?.length ??
                                                0) >=
                                            1
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: cartCompleteController
                                                .orderData
                                                .value
                                                .orderItems
                                                ?.length,
                                            itemBuilder: (context, index) {
                                              final item =
                                                  cartCompleteController
                                                      .orderData
                                                      .value
                                                      .orderItems?[index];
                                              final oldData =
                                                  cartCompleteController
                                                      .orderData.value;
                                              return _itemRow(item, () {
                                                // PLUS ACTION
                                                item?.quantity =
                                                    (item.quantity! + 1);

                                                var items = [{}];
                                                for (var element
                                                    in oldData.orderItems!) {
                                                  items.add(element.toJson());
                                                }
                                                var selectedId = SharedPref
                                                        .shared.pref!
                                                        .getString(
                                                            "primaryLocationId") ??
                                                    "";

                                                items.removeWhere((element) =>
                                                    element.keys.length <= 0);
                                                final params = {
                                                  "orderId": oldData.sId,
                                                  "paymentType": oldData
                                                      .paymentType, //prepayment
                                                  "orderPrice":
                                                      (item?.price ?? 0) *
                                                          (item?.quantity ?? 0),
                                                  "orderItems": items,
                                                  "restaurantId":
                                                      cartCompleteController
                                                          .restaurant.id,
                                                  "customerLocationId":
                                                      selectedId,
                                                  "lat": double.parse(controller
                                                      .latitude.value
                                                      .toString()),
                                                  "long": double.parse(
                                                      controller.longitude.value
                                                          .toString()),
                                                  "status": 0,
                                                  "offer":
                                                      cartCompleteController
                                                              .offerApplied
                                                              ?.offerCode ??
                                                          ""
                                                };
                                                cartCompleteController
                                                    .updateOrder(params);
                                              }, () {
                                                // MINUS ACTION
                                                if (item != null) {
                                                  if (item.quantity! > 1) {
                                                    item.quantity =
                                                        (item.quantity! - 1);

                                                    var items = [{}];
                                                    for (var element in oldData
                                                        .orderItems!) {
                                                      items.add(
                                                          element.toJson());
                                                    }

                                                    items.removeWhere(
                                                        (element) =>
                                                            element
                                                                .keys.length <=
                                                            0);
                                                    var selectedId = SharedPref
                                                            .shared.pref!
                                                            .getString(
                                                                "primaryLocationId") ??
                                                        "";
                                                    final params = {
                                                      "orderId": oldData.sId,
                                                      "paymentType": oldData
                                                          .paymentType, //prepayment
                                                      "orderPrice":
                                                          (item.price ?? 0) *
                                                              (item.quantity ??
                                                                  0),
                                                      "orderItems": items,
                                                      "restaurantId":
                                                          cartCompleteController
                                                              .restaurant.id,
                                                      "customerLocationId":
                                                          selectedId,
                                                      "lat": double.parse(
                                                          controller
                                                              .latitude.value
                                                              .toString()),
                                                      "long": double.parse(
                                                          controller
                                                              .longitude.value
                                                              .toString()),
                                                      "status": 0,
                                                      "offer":
                                                          cartCompleteController
                                                                  .offerApplied
                                                                  ?.offerCode ??
                                                              ""
                                                    };

                                                    cartCompleteController
                                                        .updateOrder(params);
                                                  }
                                                }
                                              });
                                            },
                                          )
                                        : const SizedBox.shrink(),
                                    boxA3(),
                                    customDevider(),
                                    boxA3(),
                                    Row(
                                      children: [
                                        Text(
                                          "31 mins",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        boxB1(),
                                        Text(
                                          "Delivery to 🏡 Home",
                                          style: GoogleFonts.poppins(
                                              color: AppColors.grey),
                                        ),
                                      ],
                                    ),
                                    boxA2(),
                                    TextFormField(
                                      cursorColor: Colors.black,
                                      decoration: const InputDecoration(
                                        hintText:
                                            "Add cooking instruction/request",
                                        suffixIcon: Icon(Iconsax.add),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),

                        //  HOTEL AND ORDER CONTAINER END
                        // OFFERS
                        boxA3(),
                        customContainer(
                            child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${cartCompleteController.offerApplied == null ? cartCompleteController.restaurantOffer?.first.offerCode : cartCompleteController.offerApplied?.offerCode}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "Save ₹${cartCompleteController.offerApplied == null ? cartCompleteController.restaurantOffer?.first.upto : cartCompleteController.offerApplied?.upto}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.0,
                                              color: AppColors.grey),
                                        ),
                                      ],
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    var oldData =
                                        cartCompleteController.orderData.value;

                                    if (cartCompleteController.offerApplied ==
                                        null) {
                                      cartCompleteController.offerApplied =
                                          cartCompleteController
                                              .restaurantOffer?.first;

                                      var items = [{}];
                                      for (var element in oldData.orderItems!) {
                                        items.add(element.toJson());
                                      }
                                      var selectedId = SharedPref.shared.pref!
                                              .getString("primaryLocationId") ??
                                          "";

                                      items.removeWhere((element) =>
                                          element.keys.length <= 0);
                                      if (selectedId == "") {
                                        Utils.showAlertDialog(
                                            "Please add a primary location");
                                      } else {
                                        final params = {
                                          "orderId": oldData.sId,
                                          "paymentType":
                                              oldData.paymentType, //prepayment
                                          "orderPrice": oldData.totalCost,

                                          "orderItems": items,
                                          "restaurantId": cartCompleteController
                                              .restaurant.id,
                                          "customerLocationId": selectedId,
                                          "lat": double.parse(controller
                                              .latitude.value
                                              .toString()),
                                          "long": double.parse(controller
                                              .longitude.value
                                              .toString()),
                                          "status": 0,
                                          "offer": cartCompleteController
                                                  .offerApplied?.offerCode ??
                                              ""
                                        };

                                        cartCompleteController
                                            .updateOrder(params);
                                      }
                                    } else {
                                      cartCompleteController.offerApplied =
                                          null;

                                      var items = [{}];
                                      for (var element in oldData.orderItems!) {
                                        items.add(element.toJson());
                                      }

                                      items.removeWhere((element) =>
                                          element.keys.length <= 0);
                                      var selectedId = SharedPref.shared.pref!
                                              .getString("primaryLocationId") ??
                                          "";
                                      if (selectedId == "") {
                                        Utils.showAlertDialog(
                                            "Please add a primary location");
                                      } else {
                                        final params = {
                                          "orderId": oldData.sId,
                                          "paymentType":
                                              oldData.paymentType, //prepayment
                                          "orderPrice": oldData.totalCost,

                                          "orderItems": items,
                                          "restaurantId": cartCompleteController
                                              .restaurant.id,
                                          "customerLocationId": selectedId,
                                          "lat": double.parse(controller
                                              .latitude.value
                                              .toString()),
                                          "long": double.parse(controller
                                              .longitude.value
                                              .toString()),
                                          "status": 0,
                                          "offer": cartCompleteController
                                                  .offerApplied?.offerCode ??
                                              ""
                                        };

                                        cartCompleteController
                                            .updateOrder(params);
                                      }
                                    }
                                    setState(() {});
                                  },
                                  child: Text(
                                    cartCompleteController.offerApplied != null
                                        ? "Remove"
                                        : "Apply",
                                    style: GoogleFonts.poppins(
                                        color: AppColors.theme,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            boxA1(),
                            customDevider(),
                            boxA1(),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (_) => OfferScreen(
                                      cartCompleteController:
                                          cartCompleteController,
                                    ),
                                  ),
                                )
                                    .then((val) {
                                  print("val--------------------");
                                  setState(() {});
                                });
                              },
                              child: Text(
                                "View more coupons  >",
                                style:
                                    GoogleFonts.poppins(color: AppColors.grey),
                              ),
                            )
                          ],
                        )),
                        // OFFERS END
                        // PAYMENT METHOD
                        boxA3(),
                        customContainer(
                          padding: const EdgeInsets.only(
                              top: 18.0, bottom: 18.0, right: 12.0, left: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              customContainer(
                                padding: const EdgeInsets.only(
                                    top: 9.0,
                                    bottom: 9.0,
                                    right: 24.0,
                                    left: 24.0),
                                bgColor:
                                    cartCompleteController.paymentType.value !=
                                            "prepayment"
                                        ? AppColors.backgroundblueColour
                                        : AppColors.theme,
                                onTap: () {
                                  cartCompleteController
                                      .paymentMethod("prepayment");
                                },
                                child: Text("Online",
                                    style: GoogleFonts.poppins(
                                        color: cartCompleteController
                                                    .paymentType.value !=
                                                "prepayment"
                                            ? Colors.black
                                            : Colors.white)),
                              ),
                              customContainer(
                                padding: const EdgeInsets.only(
                                    top: 9.0,
                                    bottom: 9.0,
                                    right: 24.0,
                                    left: 24.0),
                                bgColor:
                                    cartCompleteController.paymentType.value !=
                                            "prepayment"
                                        ? AppColors.theme
                                        : AppColors.backgroundblueColour,
                                onTap: () {
                                  cartCompleteController.paymentMethod("cod");
                                },
                                child: Text(
                                  "Cash On Delivery",
                                  style: GoogleFonts.poppins(
                                      color: cartCompleteController
                                                  .paymentType.value !=
                                              "prepayment"
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // PAYMENT METHOD END
                        // BILL DETAILS
                        boxA3(),

                        customContainer(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Item Total",
                                  style: GoogleFonts.poppins(
                                      color: AppColors.grey),
                                ),
                                Text(
                                    "${cartCompleteController.orderData.value.orderPrice}")
                              ],
                            ),
                            boxA2(),
                            customDevider(),
                            boxA2(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Delivery Charge",
                                  style: GoogleFonts.poppins(
                                      color: AppColors.grey),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "₹ ${double.parse(cartCompleteController.orderData.value.deliveryCharge.toString()).toStringAsFixed(2)}",
                                      style: GoogleFonts.poppins(
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                    Text(
                                      " FREE",
                                      style: GoogleFonts.poppins(
                                          color: AppColors.greenGradient),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            boxA1(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Restaurant GST",
                                  style: GoogleFonts.poppins(
                                      color: AppColors.grey),
                                ),
                                Text(
                                  "₹ ${double.parse(cartCompleteController.orderData.value.gstCharge.toString()).toStringAsFixed(2)}",
                                  //"₹${cartCompleteController.orderData.value.gstCharge}"
                                )
                              ],
                            ),
                            boxA1(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Restaurant Packing",
                                  style: GoogleFonts.poppins(
                                      color: AppColors.grey),
                                ),
                                Text(
                                    "₹${cartCompleteController.orderData.value.packingCharge}")
                              ],
                            ),
                            boxA2(),
                            customDevider(),
                            boxA2(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "TO PAY",
                                  style: GoogleFonts.poppins(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "₹ ${double.parse(cartCompleteController.orderData.value.totalCost.toString()).toStringAsFixed(2)}",
                                  style: GoogleFonts.poppins(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        )),
                        SizedBox(
                          height: SizeConfig.Height * 0.1,
                        )
                      ],
                    ).paddingAll(18.0),
                    cartCompleteController.isLoading.isTrue
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.orangeGradient,
                            ),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              ),
      ),
    );
  }
}

Widget _bottomPayButton(CartCompleteController cartCompleteController) {
  final ResturantDetailController controller =
      Get.put(ResturantDetailController());
  return Obx(
    () => Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: AppColors.greenGradient,
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            "₹ ${double.parse(cartCompleteController.orderData.value.totalCost.toString()).toStringAsFixed(2)}",
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              try {
                final oldData = cartCompleteController.orderData.value;

                var items = [{}];
                for (var element in oldData.orderItems!) {
                  items.add(element.toJson());
                }

                items.removeWhere((element) => element.keys.length <= 0);
                var selectedId =
                    SharedPref.shared.pref!.getString("primaryLocationId") ??
                        "";

                // Utils.showAlertDialog(
                //     cartCompleteController.paymentType.value.toString());
                try {
                  final params = {
                    "orderId": oldData.sId,
                    "paymentType": cartCompleteController.paymentType.value,
                    "transactionId": cartCompleteController.transactionId,
                    "cookingInstruction": "",
                    "orderPrice": oldData.totalCost,
                    "orderItems": items,
                    "restaurantId": cartCompleteController.restaurant.id,
                    "customerLocationId": selectedId,
                    "lat": double.parse(controller.latitude.value.toString()),
                    "long": double.parse(controller.longitude.value.toString()),
                    "status": 1,
                    "offer":
                        cartCompleteController.offerApplied?.offerCode ?? ""
                  };
                  print(params.toString());
                  if (cartCompleteController.paymentType.value ==
                      "prepayment") {
                    cartCompleteController.openCheckout(double.parse(
                            cartCompleteController.orderData.value.totalCost
                                .toString())
                        .toStringAsFixed(2)
                        .toString());
                  } else {
                    cartCompleteController.updateOrder(params);
                  }
                } catch (stacktrace, error) {
                  print(error.toString());
                  print(stacktrace.toString());
                }
              } catch (stacktrace, error) {
                print(stacktrace.toString());
                print(error.toString());
              }

              // cartCompleteController.updateOrder(params);
            },
            child: Row(
              children: [
                Text(
                  "Pay",
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                boxB1(),
                const Icon(
                  Iconsax.wallet,
                  color: Colors.white,
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Row _itemRow(OrderItems? item, Function onTapPlus, Function onTapMinus) {
  return Row(
    children: [
      Text(
        item?.item ?? "",
        style: GoogleFonts.poppins(
          fontSize: 16.0,
        ),
      ),
      boxB1(),
      Text(
        "₹ ${item?.price}",
        style: GoogleFonts.poppins(
          color: AppColors.grey,
          fontSize: 16.0,
        ),
      ),
      const Spacer(),
      customContainer(
          padding: const EdgeInsets.only(
              left: 12.0, right: 12.0, top: 6.0, bottom: 6.0),
          borderRadius: 100.0,
          bgColor: AppColors.greenGradient,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  onTapMinus();
                },
                child: const Icon(
                  Iconsax.minus,
                  color: Colors.white,
                ),
              ),
              boxB2(),
              Text(
                "${item?.quantity}",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
              boxB2(),
              GestureDetector(
                onTap: () {
                  onTapPlus();
                },
                child: const Icon(
                  Iconsax.add,
                  color: Colors.white,
                ),
              ),
            ],
          ))
    ],
  );
}
