import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_dish_app/screens/home/ui/searchAddressListScreen.dart';
import 'package:hello_dish_app/utilities/app_color.dart';
import 'package:hello_dish_app/utilities/const.dart';
import 'package:hello_dish_app/utilities/sizedBox.dart';
import 'package:iconsax/iconsax.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  List<Person> persons = [];
  String selectedId = '1';
  @override
  void initState() {
    persons.add(Person(
        id: "1", type: "🏡 Home", address: "Daxina Murti Society, Kodinar"));
    persons.add(Person(id: "2", type: "💼 Work", address: "Jammu, India"));
    persons.add(Person(id: "3", type: "🏢 Other", address: "Bangalore, India"));
    persons.add(Person(id: "4", type: "🏢 Hotel", address: "Jaipur, India"));

    super.initState();
  }

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.chevron_left_outlined,
                  size: 28,
                ),
              ),
              boxB2(),
              Text(
                'Search your area',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400, fontSize: 16),
              ),
            ],
          ),
          // backgroundColor: Colors.redAccent,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(const SearchAreaScreen());
                  },
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(const SearchAreaScreen());
                      },
                      child: TextField(
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        controller: searchController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(18),
                          hintText: 'Search',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 10, bottom: 10),
                            child: Icon(
                              Iconsax.search_normal4,
                              size: 20,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32),
                              borderSide:
                                  BorderSide(color: appThemeColor, width: 0.5)),
                        ),
                      ),
                    ),
                  ).paddingSymmetric(horizontal: 6),
                ),
                boxA2(),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/gps.png',
                      color: Color(0xff4791F5),
                      height: 22,
                      width: 22,
                    ),
                    Text(' Use current Location',
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff4791F5))),
                  ],
                ).paddingSymmetric(horizontal: 6),
                boxA2(),
                customDevider().paddingSymmetric(horizontal: 12),
                boxA2(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Saved Address',
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey)),
                    Icon(Iconsax.location_add4)
                  ],
                ).paddingSymmetric(horizontal: 12),
                boxA2(),
                Column(
                  children: persons.map((personone) {
                    return Slidable(
                      key: ValueKey(personone.id),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: () {}),
                        children: [
                          SlidableAction(
                            padding: EdgeInsets.all(0),
                            borderRadius: BorderRadius.circular(18),
                            onPressed: (BuildContext c) {
                              persons.removeWhere((element) {
                                return element.id == personone.id;
                              });
                            },
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.red,
                            label: '🗑 REMOVE',
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedId = personone.id;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 12)
                              ?.copyWith(top: 12),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: AppColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10.0,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              border: Border.all(
                                  color: selectedId == personone.id
                                      ? Colors.blue
                                      : AppColors.white)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        personone.type,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                      Image.asset(
                                        'assets/images/more.png',
                                        height: 22,
                                        width: 22,
                                      ),
                                    ]),
                                Text(
                                  personone.address,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.grey,
                                      fontSize: 12),
                                ),
                              ]),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ));
  }
}

class Person {
  //modal class for Person object
  String id, type, address;
  Person({required this.id, required this.type, required this.address});
}
