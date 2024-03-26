// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:hello_dish_app/screens/home/controller/homeController.dart';
import 'package:hello_dish_app/utilities/app_color.dart';
import 'package:hello_dish_app/utilities/const.dart';
import 'package:hello_dish_app/utilities/shared_pref..dart';
import 'package:hello_dish_app/utilities/sizedBox.dart';
import 'package:iconsax/iconsax.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  final HomeController controller = Get.put(HomeController());
  String selectedId = '';
  @override
  void initState() {
    super.initState();

    selectedId = SharedPref.shared.pref!.getString("primaryLocationId") ?? "";
  }

  final searchController = TextEditingController();

  var isUpdate = false;

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
        body: Obx(
          () => SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
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
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(
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
                        color: const Color(0xff4791F5),
                        height: 22,
                        width: 22,
                      ),
                      Text(' Use current Location',
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff4791F5))),
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
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (BuildContext context) {
                                        return BottomSheetLocationWidget(
                                          address: result.formattedAddress
                                              .toString(),
                                          lat: result.geometry!.location.lat,
                                          lon: result.geometry!.location.lng,
                                        );
                                      },
                                    );
                                  },
                                  initialPosition: LatLng(
                                    double.parse(controller.latitude.value),
                                    double.parse(controller.longitude.value),
                                  ),
                                  useCurrentLocation: true,
                                ),
                              ),
                            ).then((value) {
                              controller.getLocationList("");
                            });
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
                              // controller
                              //     .deleteAddress(controller.locationList[i].id);

                              Navigator.of(context).pop();
                              final item = controller.locationList[i];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlacePicker(
                                    onMapCreated: (c) {
                                      isUpdate = true;
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return BottomSheetLocation2Widget(
                                            address: item.address,
                                            lat: item.lat,
                                            lon: item.long,
                                            area: item.area,
                                            isUpdate: isUpdate,
                                            houseNo: item.houseNo,
                                            locId: item.id,
                                          );
                                        },
                                      );
                                    },
                                    selectInitialPosition: true,
                                    apiKey: Platform.isAndroid
                                        ? "AIzaSyA0mRlUvgR2LbYdrkqaGmJjaSO5LSgz7d8"
                                        : "AIzaSyA0mRlUvgR2LbYdrkqaGmJjaSO5LSgz7d8",
                                    onPlacePicked: (result) {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return BottomSheetLocation2Widget(
                                            address: result.formattedAddress
                                                .toString(),
                                            lat: result.geometry!.location.lat,
                                            lon: result.geometry!.location.lng,
                                            area: item.area,
                                            isUpdate: isUpdate,
                                            houseNo: item.houseNo,
                                            locId: item.id,
                                          );
                                        },
                                      );
                                    },
                                    initialPosition: LatLng(
                                      double.parse(controller.latitude.value),
                                      double.parse(controller.longitude.value),
                                    ),
                                    useCurrentLocation: true,
                                  ),
                                ),
                              ).then((value) {
                                controller.getLocationList("");
                              });
                            },
                            backgroundColor: Colors.transparent,
                            foregroundColor: appThemeColor,
                            label: 'UPDATE',
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedId = controller.locationList[i].id;
                            SharedPref.shared.pref!
                                .setString("primaryLocationId", selectedId);
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
                                  color: selectedId ==
                                          controller.locationList[i].id
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
                                        controller
                                            .locationList[i].locationSaveAs,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.dialog(Dialog(
                                            alignment: Alignment.center,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20,
                                                      horizontal: 25),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Are you sure want to update address?",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(); // Close the bottom sheet
                                                        },
                                                        child: const Text('No'),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                          final item = controller
                                                              .locationList[i];
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      PlacePicker(
                                                                onMapCreated:
                                                                    (c) {
                                                                  isUpdate =
                                                                      true;
                                                                  showModalBottomSheet(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return BottomSheetLocation2Widget(
                                                                        address:
                                                                            item.address,
                                                                        lat: item
                                                                            .lat,
                                                                        lon: item
                                                                            .long,
                                                                        area: item
                                                                            .area,
                                                                        isUpdate:
                                                                            isUpdate,
                                                                        houseNo:
                                                                            item.houseNo,
                                                                        locId: item
                                                                            .id,
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                selectInitialPosition:
                                                                    true,
                                                                apiKey: Platform
                                                                        .isAndroid
                                                                    ? "AIzaSyA0mRlUvgR2LbYdrkqaGmJjaSO5LSgz7d8"
                                                                    : "AIzaSyA0mRlUvgR2LbYdrkqaGmJjaSO5LSgz7d8",
                                                                onPlacePicked:
                                                                    (result) {},
                                                                initialPosition:
                                                                    LatLng(
                                                                  double.parse(
                                                                      controller
                                                                          .latitude
                                                                          .value),
                                                                  double.parse(
                                                                      controller
                                                                          .longitude
                                                                          .value),
                                                                ),
                                                                useCurrentLocation:
                                                                    true,
                                                              ),
                                                            ),
                                                          ).then((value) {
                                                            controller
                                                                .getLocationList(
                                                                    "");
                                                          });
                                                        },
                                                        child:
                                                            const Text('Yes'),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ));
                                        },
                                        child: Image.asset(
                                          'assets/images/more.png',
                                          height: 22,
                                          width: 22,
                                        ),
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
                      //

                      showModalBottomSheet(
                        builder: (context) {
                          return BottomSheetLocation2Widget(
                            address: address,
                            lat: lat,
                            lon: lon,
                          );
                        },
                        context: context,
                      );
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

class AddressType {
  String title;
  bool isSelected;
  AddressType({
    required this.title,
    required this.isSelected,
  });
}

class BottomSheetLocation2Widget extends StatefulWidget {
  final String address;
  final double lat;
  final double lon;
  final bool isUpdate;
  String? houseNo;
  String? area;
  String? locId;

  BottomSheetLocation2Widget(
      {super.key,
      required this.address,
      required this.lat,
      required this.lon,
      this.isUpdate = false,
      this.houseNo,
      this.area,
      this.locId});

  @override
  State<BottomSheetLocation2Widget> createState() =>
      _BottomSheetLocation2WidgetState();
}

class _BottomSheetLocation2WidgetState
    extends State<BottomSheetLocation2Widget> {
  var homeController = Get.put(HomeController());
  var addressType = [
    AddressType(title: "🏡 Home", isSelected: true),
    AddressType(title: "💼 Work", isSelected: false),
    AddressType(title: "🏢 Other", isSelected: false)
  ];

  TextEditingController houseNoController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    //
    if (widget.isUpdate) {
      areaController.text = widget.area ?? "";
      houseNoController.text = widget.houseNo ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(
                        width: 6,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          widget.address,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    height: 1,
                    color: AppColors.lightGrey,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonAddressTF(
                          controller: houseNoController,
                          hint: "A/302",
                          label: "House / Flate / Floor No.",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CommonAddressTF(
                          controller: areaController,
                          hint: "Mahal Road",
                          label: "Appartment/ Road / Area (Optional)",
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Save as",
                          style: GoogleFonts.poppins(
                              color: AppColors.grey, fontSize: 12),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 60,
                          child: ListView.builder(
                            itemCount: addressType.length,
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final item = addressType[index];
                              return Row(
                                children: [
                                  customContainer(
                                    margin: const EdgeInsets.only(right: 15),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 12),
                                    borderRadius: 20,
                                    borderColor: item.isSelected
                                        ? Colors.blue
                                        : AppColors.white,
                                    onTap: () {
                                      for (var element in addressType) {
                                        element.isSelected = false;
                                      }
                                      item.isSelected = !item.isSelected;
                                      setState(() {});
                                    },
                                    child: Row(
                                      children: [
                                        Text(item.title),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (houseNoController.text == "") {
                                Get.rawSnackbar(
                                    message:
                                        "Please Enter House / Flate / Floor No.");
                              } else {
                                final params = {
                                  "locationSaveAs": addressType
                                      .where((element) =>
                                          element.isSelected == true)
                                      .first
                                      .title,
                                  "houseNo": houseNoController.text,
                                  "address": widget.address,
                                  "lat": widget.lat,
                                  "long": widget.lon,
                                  "area": areaController.text
                                };
                                if (!widget.isUpdate) {
                                  homeController.addNewAddress(
                                    params,
                                    (p0) {
                                      if (p0 == true) {
                                        Get.back();
                                        Get.back();
                                      }
                                    },
                                  );
                                } else {
                                  homeController.updateAddress(
                                    widget.locId ?? "",
                                    params,
                                    (p0) {
                                      if (p0 == true) {
                                        Get.back();
                                        Get.back();
                                      }
                                    },
                                  );
                                }
                              }
                            },
                            child: Text(!widget.isUpdate
                                ? 'Save Address'
                                : 'Update Address'),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            homeController.isLoading.isTrue
                ? const CircularProgressIndicator(
                    color: AppColors.theme,
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

class CommonAddressTF extends StatelessWidget {
  CommonAddressTF(
      {super.key, this.hint = "", this.label = "", required this.controller});
  String hint;
  String label;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        label: Text(
          label,
          style: GoogleFonts.poppins(color: AppColors.grey),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.grey,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.grey,
          ),
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
