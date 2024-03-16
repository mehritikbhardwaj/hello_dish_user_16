import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_dish_app/utilities/mediaQuery.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_fade/image_fade.dart';

foodCategoryCard() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        padding: EdgeInsets.only(left: 18.0),
        //
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: ImageFade(
            image: NetworkImage(
                "https://ik.imagekit.io/freeflo/production/fe908a41-5a50-4259-9820-421484ed443d.png?tr=w-3840,q-75&alt=media&pr-true"),
            height: SizeConfig.Height * 0.11,
            width: SizeConfig.Width * 0.3,
            fit: BoxFit.cover,
            loadingBuilder: (context, progress, chunkEvent) =>
                Center(child: CircularProgressIndicator(value: progress)),
            errorBuilder: (context, error) => const Icon(
              Iconsax.user,
              color: Colors.white,
            ),
          ),
        ),
      ),
      Center(child: Text("Pizza"))
    ],
  );
}

foodCategoriesCard() {
  return GridView.builder(
    // controller: workersController.scrollController,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: SizeConfig.Height / 700,
    ),
    itemCount: 10, //HTTPClient.workers.length + 1,
    physics: const BouncingScrollPhysics(),
    shrinkWrap: true, scrollDirection: Axis.horizontal,
    itemBuilder: (BuildContext context, int index) {
      return foodCategoryCard();

      // if (index == HTTPClient.workers.length) {
      //   if (workersController.isLoadingMore != true) {
      //     return const Center(child: CircularProgressIndicator());
      //   } else {
      //     return const Center(child: Text("No more data"));
      //   }
      // } else {
      // return workerCard(model: HTTPClient.workers[index], serviceName: title);
      // }
    },
  );
}
