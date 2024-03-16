import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hello_dish_app/utilities/app_color.dart';
import 'package:hello_dish_app/utilities/const.dart';
import 'package:hello_dish_app/utilities/mediaQuery.dart';
import 'package:hello_dish_app/utilities/sizedBox.dart';
import 'package:iconsax/iconsax.dart';

import '../controller/OrderTrackingController.dart';

class OrderTrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrderTrackingController orderTrackingController = Get.put(
      OrderTrackingController(),
    );
    return GetBuilder<OrderTrackingController>(builder: (orderTrackingController) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.greenGradient,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: Text("La Pino’z Pizza"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 18.0, right: 18.0, left: 18.0),
                width: double.infinity,
                color: AppColors.greenGradient,
                child: Column(
                  children: [
                    Text(
                      "Order will be picked up shortly 🚗",
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                    boxA1(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(top: 12.0, bottom: 12.0, left: 18.0, right: 18.0),
                          decoration: BoxDecoration(
                              color: Color(0xff89C49F), borderRadius: BorderRadius.circular(12.0)),
                          child: Row(
                            children: [
                              Text(
                                "16 mins",
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                              boxB1(),
                              CircleAvatar(
                                radius: SizeConfig.Height * 0.003,
                              ),
                              boxB1(),
                              Text(
                                "On time",
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.Height * 0.6,
                width: double.infinity,
                child: GoogleMap(
                  zoomControlsEnabled: false,
                  onMapCreated: orderTrackingController.onMapCreated,
                  // myLocationEnabled: true,
                  // myLocationButtonEnabled: true,
                  onTap: (_) {},
                  compassEnabled: true,
                  markers: orderTrackingController.markers.values.toSet(),
                  initialCameraPosition: CameraPosition(
                    target: LatLng(20.8009, 70.6960),
                    zoom: 14.0,
                  ),
                  polylines: Set<Polyline>.of(orderTrackingController.polyLines.values),
                ),
              ),
              boxA3(),

              // DELIVERY PARTNER
              customContainer(
                margin: EdgeInsets.only(left: 18.0, right: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "DELIVERY PARTNER",
                      style: GoogleFonts.poppins(color: AppColors.grey),
                    ),
                    boxA1(),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: SizeConfig.Height * 0.024,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                                  "https://img.freepik.com/premium-photo/memoji-happy-man-white-background-emoji_826801-6839.jpg",
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(Iconsax.user),
                            ),
                          ),
                        ),
                        boxB1(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mohan lal",
                              style: GoogleFonts.poppins(fontSize: 15.0),
                            ).paddingOnly(bottom: 3.0),
                            Text(
                              "+91 89124589",
                              style: GoogleFonts.poppins(fontSize: 12.0),
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(Iconsax.call)
                      ],
                    ),
                  ],
                ),
              ),
              boxA2(),
              // RESTAURANT

              customContainer(
                margin: EdgeInsets.only(left: 18.0, right: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "RESTAURANT",
                      style: GoogleFonts.poppins(color: AppColors.grey),
                    ),
                    boxA1(),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: SizeConfig.Height * 0.024,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                                  "https://img.jakpost.net/c/2016/09/29/2016_09_29_12990_1475116504._large.jpg",
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(Iconsax.user),
                            ),
                          ),
                        ),
                        boxB1(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "La Pino’z Pizza",
                              style: GoogleFonts.poppins(fontSize: 15.0),
                            ).paddingOnly(bottom: 3.0),
                            Text(
                              "Soni bazar, Rajkot",
                              style: GoogleFonts.poppins(fontSize: 12.0),
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(Iconsax.call)
                      ],
                    ),
                    boxA1(),
                    Text("ORDER #879439847930"),
                    Row(children: [
                      Text("6 X "),
                      Text("Dal fry", style: GoogleFonts.poppins(fontWeight: FontWeight.w500))
                    ])
                  ],
                ),
              ),
              boxA2(),
              // ITS YOU
              customContainer(
                margin: EdgeInsets.only(left: 18.0, right: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "IT'S YOU",
                      style: GoogleFonts.poppins(color: AppColors.grey),
                    ),
                    boxA1(),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: SizeConfig.Height * 0.024,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                                  "https://img.freepik.com/photos-premium/memoji-homme-heureux-fond-blanc-emoji_826801-6831.jpg",
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(Iconsax.user),
                            ),
                          ),
                        ),
                        boxB1(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Niks, 780982909",
                              style: GoogleFonts.poppins(fontSize: 15.0),
                            ).paddingOnly(bottom: 3.0),
                            Text(
                              "Soni bazar, Rajkot",
                              style: GoogleFonts.poppins(fontSize: 12.0),
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(Iconsax.call)
                      ],
                    ),
                    boxA1(),
                    Text("Delivery at  🏡 Home",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                    Text("Daxina Murti Society, Kodinar"),
                  ],
                ),
              ),
              boxA3(),
              boxA3(),
            ],
          ),
        ),
      );
    });
  }
}
