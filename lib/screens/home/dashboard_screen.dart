import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hello_dish_app/screens/cart/ui/cartScreen.dart';
import 'package:hello_dish_app/screens/environment/ui/environmentScreen.dart';
import 'package:hello_dish_app/screens/home/ui/homeScreen.dart';
import 'package:hello_dish_app/screens/restaurant/ui/restaurantScreen.dart';
import 'package:hello_dish_app/utilities/app_color.dart';
import 'package:hello_dish_app/utilities/shared_pref..dart';
import 'package:iconsax/iconsax.dart';

class DashboardScreen extends StatefulWidget {
  final int index;

  const DashboardScreen({
    Key? key,
    this.index = 0,
  }) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  // String? profilePic = "";

  static List<Widget> _widgetOptions = <Widget>[];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Get.offAll(const DashboardScreen());
    } else if (index == 1) {
      Get.offAll(const DashboardScreen(
        index: 1,
      ));
    } else if (index == 2) {
      Get.offAll(const DashboardScreen(
        index: 2,
      ));
    } else if (index == 3) {
      Get.offAll(const DashboardScreen(
        index: 3,
      ));
    }
  }

  bool getData = false;
  getScreens() {
    setState(() {
      _widgetOptions = <Widget>[];
      _widgetOptions.add(const HomeScreen());
      _widgetOptions.add(
        const RestaurantScreen(),
      );
      _widgetOptions.add(const CartScreen());
      _widgetOptions.add(const EnvironmentScreen());

      getData = true;
    });
  }

  @override
  void initState() {
    _selectedIndex = widget.index;
    // controller.getDashboard();
    if (_selectedIndex == 3) {}
    if (_selectedIndex == 2) {}
    if (_selectedIndex == 0) {}

    SharedPref.shared.getPref();
    // Get.put(SearchAutoCompleteController());

    getScreens();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: getData
              ? _widgetOptions.elementAt(_selectedIndex)
              : const SizedBox(),
        ),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8),
                    child: GNav(
                      rippleColor: appThemeColor,
                      hoverColor: appThemeColor,
                      gap: 8,
                      activeColor: Colors.black,
                      iconSize: 24,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      duration: const Duration(milliseconds: 400),
                      tabBackgroundColor: appThemeColor,
                      color: Colors.black,
                      onTabChange: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      tabs: [
                        GButton(
                          icon: Iconsax.home_2,
                          text: 'Home',
                          iconSize: _selectedIndex == 0 ? 18 : 20.0,
                          iconActiveColor: Colors.white,
                          textStyle: GoogleFonts.poppins(
                              fontSize: 12.0, color: Colors.white),
                          textColor: Colors.white,
                        ),
                        GButton(
                          icon: Iconsax.shop,
                          text: 'Restaurant',
                          iconSize: _selectedIndex == 1 ? 18 : 20.0,
                          iconActiveColor: Colors.white,
                          textStyle: GoogleFonts.poppins(
                              fontSize: 12.0, color: Colors.white),
                          textColor: Colors.white,
                        ),
                        GButton(
                          icon: Iconsax.bag_2,
                          text: 'Cart',
                          iconSize: _selectedIndex == 2 ? 18 : 20.0,
                          iconActiveColor: Colors.white,
                          textStyle: GoogleFonts.poppins(
                              fontSize: 12.0, color: Colors.white),
                          textColor: Colors.white,
                        ),
                        GButton(
                          icon: Iconsax.setting_4,
                          text: 'Environment',
                          iconSize: _selectedIndex == 3 ? 16 : 20.0,
                          iconActiveColor: Colors.white,
                          textStyle: GoogleFonts.poppins(
                              fontSize: 12.0, color: Colors.white),
                          textColor: Colors.white,
                        ),
                      ],
                    )))));
  }
}
