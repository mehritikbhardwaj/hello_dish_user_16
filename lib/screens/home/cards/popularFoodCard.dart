// ignore: file_names
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_dish_app/utilities/mediaQuery.dart';
import 'package:iconsax/iconsax.dart';

popularFoodCard() {
  return Container(
    height: SizeConfig.Height * 0.25,
    width: SizeConfig.Width * 0.39,
    margin: const EdgeInsets.only(left: 18),
    decoration: BoxDecoration(
      color: Colors.amber,
      image: const DecorationImage(
          image: NetworkImage(
              'https://i.pinimg.com/originals/5f/ca/6d/5fca6df7e2afbd99223f7c6ff2afed3a.png'),
          fit: BoxFit.cover),
      borderRadius: BorderRadius.circular(22.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Icon(
          Iconsax.heart,
          color: Colors.white,
        ).paddingAll(18.0),
        const Spacer(),
        ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(22.0),
              bottomLeft: Radius.circular(22.0)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              color: Colors.black.withOpacity(0.3),
              padding: const EdgeInsets.all(12.0),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Paneer Frankies",
                    // maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22.0),
                              color: Colors.white.withOpacity(0.3)),
                          padding: const EdgeInsets.only(
                              top: 6.0, bottom: 6.0, right: 8.0, left: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: const Icon(
                                  Iconsax.star1,
                                  color: Colors.white,
                                  size: 15.0,
                                ).paddingOnly(right: 6.0),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '4.0',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12.0, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Text(
                          "33 min",
                          style: GoogleFonts.poppins(
                              fontSize: 12.0, color: Colors.white),
                        ).paddingOnly(left: 12.0),
                      ),
                    ],
                  ).paddingOnly(top: 6.0),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

popularFoodsCard() {
  return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return popularFoodCard();
      });
}
