import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_dish_app/utilities/mediaQuery.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_fade/image_fade.dart';

import '../models/homeModel.dart';

restaurantRectangleCard(Restaurant restaurant) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 18.0),
    child: Container(
      height: SizeConfig.Height * 0.2,
      margin: const EdgeInsets.only(left: 18.0, right: 18.0),
      decoration: BoxDecoration(
        color: Colors.amber,
        image: const DecorationImage(
            image: NetworkImage(
                'https://hips.hearstapps.com/del.h-cdn.co/assets/17/22/1600x900/hd-aspect-1496164974-delish-veggie-burgers-2.jpg?resize=640:*'),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            color: Colors.black.withOpacity(0.3),
            // padding: const EdgeInsets.all(14.0),
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: ImageFade(
                      image: NetworkImage(
                          "https://cookingfromheart.com/wp-content/uploads/2021/08/Dahi-Puri-Prep-11.jpg"),
                      height: double.infinity,
                      width: SizeConfig.Width * 0.3,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, progress, chunkEvent) => Center(
                          child: CircularProgressIndicator(value: progress)),
                      errorBuilder: (context, error) => const Icon(
                        Iconsax.user,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        restaurant.restaurantName,
                        style: GoogleFonts.poppins(
                            fontSize: 22.0, color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Iconsax.location,
                            color: Colors.white,
                            size: 15.0,
                          ).paddingOnly(right: 6.0),
                          Flexible(
                            child: Text(
                              restaurant.restaurantAddress,
                              style: GoogleFonts.poppins(color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: SizeConfig.Width * 0.16,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22.0),
                                color: Colors.white.withOpacity(0.3)),
                            padding: const EdgeInsets.only(
                                top: 6.0, bottom: 6.0, right: 6.0, left: 6.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Iconsax.star1,
                                  color: Colors.white,
                                  size: 15.0,
                                ).paddingOnly(right: 6.0),
                                Text(
                                  '${restaurant.rating}',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                color: Colors.white),
                            padding: EdgeInsets.all(3.0),
                            margin: EdgeInsets.all(12.0),
                          ),
                          Text(
                            '40 min',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                          Spacer()
                        ],
                      ),
                      Text(
                        'FREE DELIVERY',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                            color: Colors.white),
                      )
                    ],
                  ).paddingAll(18.0),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

restaurantsRectangleCard(List<Restaurant> Restaurants) {
  return ListView.builder(
      itemCount: Restaurants.length,
      shrinkWrap: true,
      // scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return restaurantRectangleCard(Restaurants[index]);
      });
}
