import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utilities/app_color.dart';
import '../../../utilities/mediaQuery.dart';
import '../models/homeModel.dart';

cuisineCard(String img, Restaurant restaurant) {
  return Container(
    height: SizeConfig.Height * 0.24,
    width: SizeConfig.Width * 0.39,
    margin: const EdgeInsets.only(left: 18),
    decoration: BoxDecoration(
        color: Colors.amber,
        image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(color: Colors.white)),
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
                    restaurant.restaurantName,
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
                                  '${restaurant.rating}',
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

// cuisinesCard({img, cuisineTitle, color}) {
//   return Column(
//     children: [
//       Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [color, Colors.transparent],
//             ),
//           ),
//           child: Column(
//             children: [
//               Text(
//                 cuisineTitle,
//                 style: GoogleFonts.poppins(
//                     color: Colors.white,
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.w500),
//               ).paddingAll(18.0),
//               SizedBox(
//                 height: SizeConfig.Height * 0.24,
//                 width: 500,
//                 child: ListView.builder(
//                     itemCount: 5,
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     physics: const BouncingScrollPhysics(),
//                     itemBuilder: (BuildContext context, int index) {
//                       return cuisineCard(img);
//                     }),
//               ),
//             ],
//           )),
//     ],
//   );
// }
cuisinesCard(
    {img, cuisineTitle, color, required List<Restaurant> restaurants}) {
  return Column(
    children: [
      Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [color, Colors.transparent],
            ),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cuisineTitle,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
              ).paddingAll(18.0),
              SizedBox(
                height: SizeConfig.Height * 0.24,
                width: 500,
                child: ListView.builder(
                    itemCount: restaurants
                        .length, // Use the length of restaurants list
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return cuisineCard(img, restaurants[index]);
                    }),
              ),
            ],
          )),
    ],
  );
}
