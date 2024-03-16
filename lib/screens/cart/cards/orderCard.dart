import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_dish_app/utilities/app_color.dart';
import 'package:hello_dish_app/utilities/const.dart';
import 'package:hello_dish_app/utilities/mediaQuery.dart';
import 'package:hello_dish_app/utilities/sizedBox.dart';
import 'package:iconsax/iconsax.dart';

orderCard(int index, btn, onPressed) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: SizeConfig.Height * 0.024,
                      width: SizeConfig.Width * 0.01,
                      decoration: BoxDecoration(
                          color: AppColors.theme, borderRadius: BorderRadius.circular(100.0)),
                    ),
                    Text("Order not placed").paddingOnly(left: 12.0)
                  ],
                ),
                boxA2(),
                Row(children: [
                  Text("6 X "),
                  Text("Dal fry", style: GoogleFonts.poppins(fontWeight: FontWeight.w500))
                ]),
                Text("₹ 100"),
                boxA2(),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: SizeConfig.Height * 0.09,
              width: SizeConfig.Width * 0.18,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22.0),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      "https://assets.gqindia.com/photos/6213cbed18140d747a9b0a6e/16:9/w_1920,h_1080,c_limit/new%20restaurant%20menus%20in%20Mumbai.jpg",
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Iconsax.user),
                ),
              ),
            ),
          ),
        ],
      ),
      Row(children: [
        Text("₹ 600 /- "),
        Text("PAID", style: GoogleFonts.poppins(color: AppColors.grey))
      ]),
      boxA1(),
      ElevatedButton(
        onPressed: onPressed,
        child: Text(btn != true ? "Order now" : "Cancel"),
      ),
      boxA3(),
      customDevider(),
      boxA3(),
    ],
  );
}

ordersCard({btn, onPressed}) {
  return ListView.builder(
      itemCount: 2,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return orderCard(index, btn, onPressed);
      });
}
