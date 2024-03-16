import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_dish_app/screens/cart/controller/cartCompleteController.dart';
import 'package:hello_dish_app/screens/cart/ui/offerScreen.dart';
import 'package:hello_dish_app/screens/cart/ui/orderTrackingScreen.dart';
import 'package:hello_dish_app/screens/home/models/restaurentDetails.dart';
import 'package:hello_dish_app/utilities/app_color.dart';
import 'package:hello_dish_app/utilities/const.dart';
import 'package:hello_dish_app/utilities/mediaQuery.dart';
import 'package:hello_dish_app/utilities/sizedBox.dart';
import 'package:iconsax/iconsax.dart';

class CartCompleteScreen extends StatefulWidget {
  const CartCompleteScreen({super.key});

  @override
  State<CartCompleteScreen> createState() => _CartCompleteScreenState();
}

class _CartCompleteScreenState extends State<CartCompleteScreen> {
  final CartCompleteController cartCompleteController =
      Get.put(CartCompleteController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartCompleteController>(
        builder: (cartCompleteController) {
      return Scaffold(
        appBar: AppBar(),
        floatingActionButton: Container(
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
                "₹ ${cartCompleteController.orderPrice}",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(() => OrderTrackingScreen());
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
        ).paddingOnly(left: 30.0),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                //  HOTEL AND ORDER CONTAINER
                customContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartCompleteController.restaurant.restaurantName,
                        style: GoogleFonts.poppins(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      boxA1(),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartCompleteController
                            .orderData.value.orderItems?.length,
                        itemBuilder: (context, index) {
                          final item = cartCompleteController
                              .orderData.value.orderItems?[index];
                          return _itemRow(item as OrderItem);
                        },
                      ),
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
                            style: GoogleFonts.poppins(color: AppColors.grey),
                          ),
                        ],
                      ),
                      boxA2(),
                      TextFormField(
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          hintText: "Add cooking instruction/request",
                          suffixIcon: Icon(Iconsax.add),
                        ),
                      )
                    ],
                  ),
                ),

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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      fontSize: 12.0, color: AppColors.grey),
                                ),
                              ],
                            )),
                        GestureDetector(
                          onTap: () {
                            if (cartCompleteController.offerApplied == null) {
                              cartCompleteController.offerApplied =
                                  cartCompleteController.restaurantOffer?.first;
                            } else {
                              cartCompleteController.offerApplied = null;
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
                              cartCompleteController: cartCompleteController,
                            ),
                          ),
                        )
                            .then((val) {
                          print("val--------------------");
                          setState(() {});
                        });

                        // Get.to(
                        //   () => OfferScreen(
                        //     cartCompleteController: cartCompleteController,
                        //   ),
                        // )?.then((value) => (value) {
                        //       print("insede callnback");
                        //       setState(() {});
                        //     });
                      },
                      child: Text(
                        "View more coupons  >",
                        style: GoogleFonts.poppins(color: AppColors.grey),
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
                            top: 9.0, bottom: 9.0, right: 24.0, left: 24.0),
                        bgColor: cartCompleteController.paymentType.value
                            ? AppColors.backgroundblueColour
                            : AppColors.theme,
                        onTap: () {
                          cartCompleteController.paymentMethod();
                        },
                        child: Text("Online",
                            style: GoogleFonts.poppins(
                                color: cartCompleteController.paymentType.value
                                    ? Colors.black
                                    : Colors.white)),
                      ),
                      customContainer(
                        padding: const EdgeInsets.only(
                            top: 9.0, bottom: 9.0, right: 24.0, left: 24.0),
                        bgColor: cartCompleteController.paymentType.value
                            ? AppColors.theme
                            : AppColors.backgroundblueColour,
                        onTap: () {
                          cartCompleteController.paymentMethod();
                        },
                        child: Text(
                          "Cash On Delivery",
                          style: GoogleFonts.poppins(
                              color: cartCompleteController.paymentType.value
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
                          style: GoogleFonts.poppins(color: AppColors.grey),
                        ),
                        const Text("₹200")
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
                          style: GoogleFonts.poppins(color: AppColors.grey),
                        ),
                        Row(
                          children: [
                            Text(
                              "₹200",
                              style: GoogleFonts.poppins(
                                  decoration: TextDecoration.lineThrough),
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
                          style: GoogleFonts.poppins(color: AppColors.grey),
                        ),
                        const Text("₹11.00")
                      ],
                    ),
                    boxA1(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Restaurant Packing",
                          style: GoogleFonts.poppins(color: AppColors.grey),
                        ),
                        const Text("₹00.30")
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
                              fontSize: 18.0, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "₹ 211.30",
                          style: GoogleFonts.poppins(
                              fontSize: 18.0, fontWeight: FontWeight.w500),
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
          ),
        ),
      );
    });
  }

  Row _itemRow(OrderItem item) {
    return Row(
      children: [
        Text(
          item.item,
          style: GoogleFonts.poppins(
            fontSize: 16.0,
          ),
        ),
        boxB1(),
        Text(
          "₹ ${item.price}",
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
                const Icon(
                  Iconsax.minus,
                  color: Colors.white,
                ),
                boxB2(),
                Text(
                  "${item.quantity}",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
                boxB2(),
                const Icon(
                  Iconsax.add,
                  color: Colors.white,
                ),
              ],
            ))
      ],
    );
  }
}
