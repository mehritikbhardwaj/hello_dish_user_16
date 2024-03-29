import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../utilities/app_color.dart';
import '../../../../utilities/const.dart';
import '../../../../utilities/mediaQuery.dart';
import '../../../../utilities/sizedBox.dart';
import '../../controller/orderController.dart';

class CancelOrdersScreen extends StatelessWidget {
  const CancelOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<CartOrderController>().getOrderList();
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<CartOrderController>(
            builder: (c) {
              if(c.allOrderList?.value!=null) {
                return Container(
                  height: SizeConfig.Height * 0.9,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: c.allOrderList?.value.data.length,
                      itemBuilder: (context, index) {
                        if (c.allOrderList!.value.data[index].status == 1) {
                          final list=c.allOrderList!.value.data[index];
                          return SizedBox(
                            width: SizeConfig.Width * 1,
                            child: canceledOrderCard(() {
                              // Get.to(OrderStatus());
                            },list.orderItems[0].quantity,list.orderItems[0].item,
                                list.orderItems[0].price,
                                list.orderItems[0].image,list.orderPrice,list.createdAt),
                          ).paddingOnly(left: 18.0, right: 18.0);
                        }
                        else {
                          return SizedBox.shrink();
                        }
                      }),
                );
              }
              else{
                return Container();
              }
            }
        ),
      ),
    );
  }
}
canceledOrderCard(onPressed,quantity,item,price,imgUrl,orderPrice,createdAt) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                          color: AppColors.redGradient, borderRadius: BorderRadius.circular(100.0)),
                    ),
                    Text(
                      "Order Canceled",
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                    ).paddingOnly(left: 12.0)
                  ],
                ),
                boxA2(),
                Row(children: [
                  Text(
                    "$quantity X ",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                    ),
                  ),
                  Text(item, style: GoogleFonts.poppins(fontWeight: FontWeight.w500))
                ]),
                Text("₹ $price"),
                boxA1(),
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
                  imageUrl:imgUrl??
                      "https://assets.gqindia.com/photos/6213cbed18140d747a9b0a6e/16:9/w_1920,h_1080,c_limit/new%20restaurant%20menus%20in%20Mumbai.jpg",
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Iconsax.user),
                ),
              ),
            ),
          ),
        ],
      ),
      Divider(
        color: Colors.grey.shade300,
      ),
      boxA1(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Text("₹ $orderPrice /- "),
            // Text("Paid",style: GoogleFonts.poppins(color:Colors.green,fontWeight:FontWeight.w500,fontSize:14),),

          ]),
          Text(formatDate(createdAt),
              style: GoogleFonts.poppins(color: AppColors.grey, fontSize: 12))
        ],
      ),
      boxA2(),
      customDevider(),
      boxA3(),
    ],
  );
}
String formatDate(DateTime dateTime) {
  final formatter = DateFormat('dd MMM yyyy \'at\' hh:mm a');
  return formatter.format(dateTime);
}
