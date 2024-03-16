import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_dish_app/screens/home/models/restaurentDetails.dart';

import '../../../utilities/app_color.dart';
import '../../../utilities/const.dart';
import '../../../utilities/sizedBox.dart';
import '../controller/cartCompleteController.dart';

class OfferScreen extends StatefulWidget {
  OfferScreen({super.key, this.cartCompleteController});
  CartCompleteController? cartCompleteController;

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  final _searchController = TextEditingController();
  List<RestaurantOffer>? copyOffers;

  @override
  void initState() {
    // TODO: implement initState
    copyOffers = widget.cartCompleteController?.restaurantOffer;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartCompleteController>(
        builder: (cartCompleteController) {
      return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: "Search"),
                controller: _searchController,
                onChanged: (value) {
                  if (value != "") {
                    copyOffers = copyOffers
                        ?.where((element) => element.offerCode
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                    setState(() {});
                  } else {
                    setState(() {
                      copyOffers =
                          widget.cartCompleteController?.restaurantOffer;
                    });
                  }
                },
              ),
              boxA3(),
              copyOffers != null
                  ? ListView.builder(
                      itemCount: copyOffers?.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final item = copyOffers?[index];
                        return Column(
                          children: [
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
                                              "Flat OFF ₹${item?.discount} /-",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "Save ₹${item?.upto}",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12.0,
                                                  color: AppColors.grey),
                                            ),
                                          ],
                                        )),
                                    customContainer(
                                      padding: const EdgeInsets.only(
                                          left: 18.0,
                                          right: 18.0,
                                          top: 9.0,
                                          bottom: 9.0),
                                      bgColor: AppColors.greenGradient,
                                      child: Text(
                                        item?.offerCode ?? "",
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                boxA2(),
                                customDevider(),
                                boxA2(),
                                GestureDetector(
                                  onTap: () {
                                    // Get.to(() => OfferScreen());
                                    cartCompleteController.offerApplied = item;
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Apply",
                                    style: GoogleFonts.poppins(
                                        color: AppColors.theme),
                                  ),
                                )
                              ],
                            )),
                            boxA1()
                          ],
                        );
                      })
                  : const SizedBox.shrink(),
            ],
          ).paddingAll(18.0),
        ),
      );
    });
  }
}
