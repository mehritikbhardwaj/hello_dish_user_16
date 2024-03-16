import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_dish_app/utilities/app_color.dart';

import '../../models/restaurentDetails.dart';

class MealItemsWidget extends StatefulWidget {
  final String mealName;
  final List<dynamic> items;

  const MealItemsWidget(
      {super.key, required this.mealName, required this.items});

  @override
  _MealItemsWidgetState createState() => _MealItemsWidgetState();
}

class _MealItemsWidgetState extends State<MealItemsWidget> {
  final bool _isExpanded = false;
  bool visible = false;
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        visible = !visible;
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      color: AppColors.backgroundblueColour,
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                child: Text(
                                  '${widget.mealName} (${widget.items.length})',
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                '4',
                                style: th.bodyMedium?.copyWith(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          Icon(
                            _isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            size: 30,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (visible && selectedIndex == index),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.items.length,
                        itemBuilder: (context, indx) {
                          var item = widget.items[index];
                          var itemName = item['name'];
                          var itemPrice = item['price'].toString();
                          var itemImage = item['image'];
                          return const SizedBox(); //order(itemName, itemPrice, itemImage);
                        }),
                  ),
                ],
              ),
            ),
          ),
        )

        // InkWell(
        //   onTap: () {
        //     setState(() {
        //       _isExpanded = !_isExpanded;
        //     });
        //   },
        //   child: Container(
        //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        //     color: Colors.white,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Text(
        //           '${widget.mealName} (${widget.items.length})',
        //           style: GoogleFonts.poppins(
        //             fontSize: 20,
        //             fontWeight: FontWeight.w600,
        //           ),
        //         ),
        //         Icon(
        //           _isExpanded
        //               ? Icons.keyboard_arrow_up
        //               : Icons.keyboard_arrow_down,
        //           size: 30,
        //           color: Colors.black,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // if (_isExpanded && widget.items.isNotEmpty)
        //   ListView.builder(
        //     shrinkWrap: true,
        //     physics: NeverScrollableScrollPhysics(),
        //     itemCount: widget.items.length,
        //     itemBuilder: (context, index) {
        //       var item = widget.items[index];
        //       var itemName = item['name'];
        //       var itemPrice = item['price'].toString();
        //       var itemImage = item['image'];
        //       return order(itemName, itemPrice, itemImage);
        //     },
        //   ),
        // boxA3(),
      ],
    );
  }
}

List<Widget> generateMealItems(List<ItemWrapper> foodItems) {
  List<Widget> widgets = [];
  for (int i = 0; i < foodItems.length; i++) {
    var mealName = foodItems[i].meal.name;
    var items = foodItems[i].items;
    if (items.isNotEmpty) {
      widgets.add(MealItemsWidget(mealName: mealName, items: items));
    }
  }
  return widgets;
}
