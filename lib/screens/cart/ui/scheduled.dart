import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_dish_app/screens/cart/ui/cartCompleteScreen.dart';
import 'package:hello_dish_app/utilities/app_color.dart';
import 'package:hello_dish_app/utilities/sizedBox.dart';

import '../../../utilities/mediaQuery.dart';
import '../cards/orderCard.dart';
import '../controller/scheduledController.dart';

class ScheduledScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScheduledController scheduledController = Get.put(
      ScheduledController(),
    );
    return GetBuilder<ScheduledController>(builder: (scheduledController) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("5 ORDER READY TO PLACE",
                      style: GoogleFonts.poppins(
                          fontSize: 18.0, fontWeight: FontWeight.w500))
                  .paddingOnly(left: 18.0, right: 18.0),
              boxA3(),
              SizedBox(
                width: SizeConfig.Width * 1,
                child: ordersCard(onPressed: () {
                  Get.to(CartCompleteScreen());
                }),
              ).paddingOnly(left: 18.0, right: 18.0),
              // Container(
              //   color: AppColors.theme.withOpacity(0.5),
              //   height: SizeConfig.Height * 0.03,
              // ),
              boxA3(),
              SizedBox(
                width: SizeConfig.Width * 1,
                child: ordersCard(btn: true, onPressed: () {}),
              ).paddingOnly(left: 18.0, right: 18.0),
            ],
          ),
        ),
      );
    });
  }
}
