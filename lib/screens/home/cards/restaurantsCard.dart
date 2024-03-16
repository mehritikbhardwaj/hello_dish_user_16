// import 'package:flutter/material.dart';

// brandCard(model, BuildContext context, SearchViewModel searchProvider) {
//   return Padding(
//       padding: const EdgeInsets.only(left: 10.0, top: 8, right: 10, bottom: 8),
//       child: InkWell(
//         onTap: () {
//           searchProvider.clearFilters();

//           searchProvider.brandId = model.id.toString();
//           searchProvider.isHome = false;
//           Routes.navigateToSearchScreen(context);
//           searchProvider.getProductsListNew(context, "25", "1");
//         },
//         child: Column(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8.0),
//               child: CachedNetworkImage(
//                 imageUrl: model.image,
//                 height: size_50,
//                 fit: BoxFit.fill,
//                 placeholder: (context, url) => appLoader(),
//                 errorWidget: (context, url, error) => const Icon(Icons.error),
//               ),
//             ),
//             const SizedBox(
//               height: size_5,
//             ),
//             Text(
//               model.name,
//               style: const TextStyle(color: Colors.black, fontSize: size_10),
//             )
//           ],
//         ),
//       ));
// }

// Row brandsCard(BuildContext context, List<BrandsList> model, SearchViewModel searchViewModel) =>
//     Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Container(
//           decoration: const BoxDecoration(color: Colors.white),
//           child: Row(
//             children: List.generate(
//               model.length > 5 ? 5 : model.length,
//               (index) => brandCard(model[index], context, searchViewModel),
//             ),
//           ),
//         )
//       ],
//     );

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_dish_app/utilities/mediaQuery.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utilities/api_manager/apis.dart';
import '../../../utilities/api_manager/http_client.dart';
import '../models/homeModel.dart';
import '../ui/resturant/resturant_detail_screen.dart';

class RestaurantCard extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  late bool isFavAdded;

  @override
  void initState() {
    super.initState();
    isFavAdded = (widget.restaurant.isFav == 1);
  }

  @override
  Widget build(BuildContext context) {
    String url = '${APIs.addFav}${widget.restaurant.id}';
    return Container(
      height: SizeConfig.Height * 0.25,
      margin: const EdgeInsets.only(left: 18.0),
      decoration: BoxDecoration(
        color: Colors.amber,
        image: const DecorationImage(
            image: NetworkImage(
                'https://hips.hearstapps.com/del.h-cdn.co/assets/17/22/1600x900/hd-aspect-1496164974-delish-veggie-burgers-2.jpg?resize=640:*'),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(22.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () async {
              if (isFavAdded == false) {
                await HTTPClient.addFav(url);
                setState(() {
                  isFavAdded = true;
                });
              } else {
                setState(() {
                  isFavAdded = false;
                });
              }
            },
            child: Icon(
              isFavAdded ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
              size: 36.0,
            ).paddingAll(18.0),
          ),
          const Spacer(),
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(22.0),
                bottomLeft: Radius.circular(22.0)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                color: Colors.black.withOpacity(0.3),
                padding: const EdgeInsets.all(14.0),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.restaurant.restaurantName,
                          style: GoogleFonts.poppins(
                              fontSize: 18.0, color: Colors.white),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Iconsax.location,
                              color: Colors.white,
                              size: 15.0,
                            ).paddingOnly(right: 6.0),
                            Text(
                              widget.restaurant.restaurantAddress,
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                          ],
                        ).paddingOnly(top: 6.0),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22.0),
                          color: Colors.white.withOpacity(0.3)),
                      padding: const EdgeInsets.only(
                          top: 6.0, bottom: 6.0, right: 8.0, left: 8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Iconsax.star1,
                            color: Colors.white,
                            size: 15.0,
                          ).paddingOnly(right: 6.0),
                          Text(
                            '${widget.restaurant.rating}',
                            style: GoogleFonts.poppins(color: Colors.white),
                          )
                        ],
                      ),
                    ).paddingOnly(left: 12.0)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantsCard extends StatefulWidget {
  final List<Restaurant> Restaurants;

  const RestaurantsCard({super.key, required this.Restaurants});

  @override
  State<RestaurantsCard> createState() => _RestaurantsCardState();
}

class _RestaurantsCardState extends State<RestaurantsCard> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.Restaurants.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: () {
                Get.to(ResturantDetailScreen(
                  restaurant: widget.Restaurants[index],
                ));
              },
              child: RestaurantCard(restaurant: widget.Restaurants[index]));
        });
  }
}

restaurantCard(Restaurant restaurant) {
  return Container(
    height: SizeConfig.Height * 0.25,
    margin: const EdgeInsets.only(left: 18.0),
    decoration: BoxDecoration(
      color: Colors.amber,
      image: const DecorationImage(
          image: NetworkImage(
              'https://hips.hearstapps.com/del.h-cdn.co/assets/17/22/1600x900/hd-aspect-1496164974-delish-veggie-burgers-2.jpg?resize=640:*'),
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
              padding: const EdgeInsets.all(14.0),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.restaurantName,
                        style: GoogleFonts.poppins(
                            fontSize: 18.0, color: Colors.white),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Iconsax.location,
                            color: Colors.white,
                            size: 15.0,
                          ).paddingOnly(right: 6.0),
                          Text(
                            restaurant.restaurantAddress,
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ],
                      ).paddingOnly(top: 6.0),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22.0),
                        color: Colors.white.withOpacity(0.3)),
                    padding: const EdgeInsets.only(
                        top: 6.0, bottom: 6.0, right: 8.0, left: 8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Iconsax.star1,
                          color: Colors.white,
                          size: 15.0,
                        ).paddingOnly(right: 6.0),
                        Text(
                          '${restaurant.rating}',
                          style: GoogleFonts.poppins(color: Colors.white),
                        )
                      ],
                    ),
                  ).paddingOnly(left: 12.0)
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

restaurantsCard(List<Restaurant> Restaurants) {
  return ListView.builder(
      itemCount: Restaurants.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return restaurantCard(Restaurants[index]);
      });
}
