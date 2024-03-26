import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_dish_app/utilities/sizedBox.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utilities/app_color.dart';
import '../../../utilities/mediaQuery.dart';
import '../../home/cards/restaurantsRectangleCard.dart';
import '../controller/search_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchGetController=Get.put(SearchGetController());
    final searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
            ),
            child: TextField(
              autofocus: true,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              controller: searchController,
              keyboardType: TextInputType.text,
              onTap: (){
                searchGetController.putFilters();
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(18),
                hintText: 'Search food, Restaurant, Dish',
                prefixIcon:  const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Icon( Iconsax.search_normal,),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: const BorderSide(color: AppColors.grey, width: 0.5)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: const BorderSide(color: AppColors.textBlack, width: 0.5)),
              ),
            ),
          ).paddingSymmetric(horizontal: 12),
          boxA1(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                DropdownMenu(),
                boxB1(),
                filterTag('Non Veg',(){
                  searchGetController.getPureVeg();
                  searchGetController.putFilters();
                },searchGetController.isVeg),
                boxB1(),
                filterTag('Less Than 30 mins',(){
                  searchGetController.getTime();
                  searchGetController.putFilters();
                },searchGetController.isTime),
              ],
            ).paddingSymmetric(horizontal: 12),
          ),
          boxA1(),
          Obx(
             () {
              return SizedBox(
                width: SizeConfig.Width * 5,
                // height: SizeConfig.Height * 0.3,
                child: restaurantsFilterRectangleCard(
                    searchGetController.nearByRestaurantList.value),
              );
            }
          ),
        ],
      ),
    );
  }
  Widget filterTag(text,_onPress,isVeg){
    final controllerX = Get.find<SearchGetController>();

    return Obx(
       () {
        return InkWell(
          onTap: _onPress,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
            decoration: BoxDecoration(
                color: isVeg.value?appThemeColor:AppColors.white,
                border: Border.all(color: isVeg.value?AppColors.white:AppColors.grey),
                borderRadius: BorderRadius.circular(22)
            ),
            child: Row(
              children: [
                Text(
                  text,
                  style:  TextStyle(
                      fontSize: 12.0, color: isVeg.value?Colors.white:AppColors.textBlack),
                ),
                isVeg.value? Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Icon(Icons.cancel_outlined,size: 16 ,color: Colors.white,),
                ):const SizedBox.shrink(),
              ],
            ),
          ),
        );
      }
    );
  }
}

class DropdownMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controllerX = Get.find<SearchGetController>();
    return PopupMenuButton<String>(
      surfaceTintColor: Colors.white,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      onSelected: (String value) {
        controllerX.selectedFilter(value);
        controllerX.putFilters();
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
         PopupMenuItem<String>(
          value: 'relevance',
          child: ListTile(
            title:  Text('Relevance',style: GoogleFonts.poppins(
              fontSize:14,
              color:controllerX.filter=='relevance'?Colors.black:AppColors.grey,
            ),),
            trailing:dot(controllerX.filter=='relevance'),

          ),
        ),
        PopupMenuItem<String>(
          value: 'ratingHighToLow',
          child: ListTile(
            title:  Text('Rating (High to Low)',style: GoogleFonts.poppins(
              fontSize:14,
              color:controllerX.filter=='ratingHighToLow'?Colors.black:AppColors.grey,
            ),),
            trailing:dot(controllerX.filter=='ratingHighToLow'),

          ),
        ),
         PopupMenuItem<String>(
          value: 'deliveryTime',
          child: ListTile(
            title: Text('Delivery Time',style: GoogleFonts.poppins(
              fontSize:14,
              color:controllerX.filter=='deliveryTime'?Colors.black:AppColors.grey,
            ),),
            trailing:dot(controllerX.filter=='deliveryTime'),

          ),
        ),
         PopupMenuItem<String>(
          value: 'priceHighToLow',
          child: ListTile(
            title:  Text('Price (High to Low)',style: GoogleFonts.poppins(
              fontSize:14,
              color:controllerX.filter=='priceHighToLow'?Colors.black:AppColors.grey,
            ),),
            trailing:dot(controllerX.filter=='priceHighToLow'),
          ),
        ),
         PopupMenuItem<String>(
          value: 'priceLowToHigh',
          child: ListTile(
            title:  Text('Price (Low to High)',style: GoogleFonts.poppins(
              fontSize:14,
              color:controllerX.filter=='priceLowToHigh'?Colors.black:AppColors.grey,
            ),),
            trailing:dot(controllerX.filter=='priceLowToHigh'),

          ),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(22),
        ),
        child: const Row(
          children: [
            Text(
              "Sort by",
              style: TextStyle(fontSize: 12.0, color: AppColors.textBlack),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.0,left: 4),
              child: Icon(CupertinoIcons.chevron_down, size: 14),
            ),
          ],
        ),
      ),
    );
  }
  Widget dot(isColor){
    return Container(
      height: 20,
      width: 20,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: isColor?appThemeColor:AppColors.grey,)
      ),
      child: Container(
        height: 16,
        width: 16,
        decoration: BoxDecoration(
            color: isColor?appThemeColor:Colors.transparent,
            shape: BoxShape.circle,
        ),
      ),
    );
  }
}