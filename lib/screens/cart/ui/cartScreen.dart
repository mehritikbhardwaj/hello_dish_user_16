import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_dish_app/screens/cart/ui/cartCompleteScreen.dart';
import 'package:hello_dish_app/screens/cart/ui/scheduled.dart';
import 'package:hello_dish_app/utilities/app_color.dart';

import '../controller/orderController.dart';
import 'CartOrders/cancel_order_screen.dart';
import 'CartOrders/cart_completed_order.dart';
import 'CartOrders/scheduled_order_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    Get.put(CartOrderController()).getOrderList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bookings'),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    offset: const Offset(0, 1),
                    blurRadius: 9,
                  ),
                ],
              ),
              width: double.infinity,
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                        surfaceVariant: Colors.transparent,
                      ),
                ),
                child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                      color: AppColors.theme,
                      borderRadius: BorderRadius.circular(100.0)),
                  tabs: const [
                    Tab(text: 'Scheduled'),
                    Tab(text: 'Completed'),
                    Tab(text: 'Cancelled'),
                  ],
                ),
              ),
            ).paddingAll(10.0),
            const Expanded(
              child: TabBarView(
                children: [
                  ScheduledOrdersScreen(),
                  CompletedOrdersScreen(),
                  CancelOrdersScreen(),
                  // upComing(),
                  // completed(),
                  // cancelled(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
