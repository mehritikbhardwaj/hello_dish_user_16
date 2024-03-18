import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:hello_dish_app/screens/home/controller/homeController.dart';
import 'package:hello_dish_app/screens/home/ui/address/addressMapScreen.dart';
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
  final HomeController controller = Get.put(HomeController());
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
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Search your area',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400, fontSize: 16),
                ),
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
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: TextField(
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    controller: searchController,
                    onChanged: (val) {
                      controller.getLocationList(val);
                      setState(() {});
                    },
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
                ).paddingSymmetric(horizontal: 6),
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
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlacePicker(
                                selectInitialPosition: true,
                                apiKey: Platform.isAndroid
                                    ? "AIzaSyA0mRlUvgR2LbYdrkqaGmJjaSO5LSgz7d8"
                                    : "AIzaSyA0mRlUvgR2LbYdrkqaGmJjaSO5LSgz7d8",
                                onPlacePicked: (result) {
                                  print(result.formattedAddress);

                                  //  restaurantList.clear();
                                  setState(() {
                                    // addressC.text = result.formattedAddress.toString();
                                    // lat = result.geometry!.location.lat;
                                    // long = result.geometry!.location.lng;
                                    // cityC.text = result.city
                                    // stateC.text = result.administrativeAreaLevel1!.name.toString();
                                    // countryC.text = result.country!.name.toString();
                                    // pincodeC.text = result.postalCode.toString();
                                  });
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return BottomSheetLocationWidget(
                                        address:
                                            result.formattedAddress.toString(),
                                        lat: result.geometry!.location.lat,
                                        lon: result.geometry!.location.lng,
                                      );
                                    },
                                  );
                                  //  getRestaurants();
                                  // Navigator.of(context).pop();
                                },
                                initialPosition: LatLng(
                                  double.parse(controller.latitude.value),
                                  double.parse(controller.longitude.value),
                                ),
                                useCurrentLocation: true,
                              ),
                            ),
                          );
                        },
                        child: const Icon(Iconsax.location_add4))
                  ],
                ).paddingSymmetric(horizontal: 12),
                boxA2(),
                for (int i = 0; i < controller.locationList.length; i++)
                  Slidable(
                    key: ValueKey(controller.locationList[i].id),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(onDismissed: () {}),
                      children: [
                        SlidableAction(
                          padding: const EdgeInsets.all(0),
                          borderRadius: BorderRadius.circular(18),
                          onPressed: (BuildContext c) {
                            // persons.removeWhere((element) {
                            //   return element.id ==
                            //       controller.locationList[i].id;
                            // });
                          },
                          backgroundColor: Colors.transparent,
                          foregroundColor: appThemeColor,
                          label: '🗑 REMOVE',
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedId = controller.locationList[i].id;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12)
                            .copyWith(top: 12),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: AppColors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10.0,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            border: Border.all(
                                color:
                                    selectedId == controller.locationList[i].id
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
                                      controller.locationList[i].locationSaveAs,
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
                                controller.locationList[i].address,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.grey,
                                    fontSize: 12),
                              ),
                            ]),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ));
  }
}

class BottomSheetLocationWidget extends StatelessWidget {
  final String address;
  final double lat;
  final double lon;

  const BottomSheetLocationWidget(
      {super.key, required this.address, required this.lat, required this.lon});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: [
                const Icon(Icons.location_on),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    address,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the bottom sheet
                      // Add your button 1 action here
                    },
                    child: Image.asset(
                      "assets/images/gps.png",
                      height: 25,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 6,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the bottom sheet
                      // Add your button 2 action here
                    },
                    child: const Text('Confirm Location'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Person {
  //modal class for Person object
  String id, type, address;
  Person({required this.id, required this.type, required this.address});
}
