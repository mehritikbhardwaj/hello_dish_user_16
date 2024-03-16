import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_dish_app/utilities/app_color.dart';

Widget customTitle({title, subtitle, rTitle, rSubtitle, onTap, paddingTop}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle ?? "",
            style: GoogleFonts.poppins(color: AppColors.grey),
          ),
          Text(
            title ?? "",
            style: GoogleFonts.poppins(fontSize: 24.0),
          ),
        ],
      ).paddingOnly(top: paddingTop ?? 18.0, bottom: 18.0),
      GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rSubtitle ?? "",
              style: GoogleFonts.poppins(color: AppColors.grey),
            ),
            Text(
              rTitle ?? "",
              style: GoogleFonts.poppins(fontSize: 24.0),
            ),
          ],
        ).paddingOnly(top: paddingTop ?? 18.0, bottom: 18.0),
      ),
    ],
  );
}
