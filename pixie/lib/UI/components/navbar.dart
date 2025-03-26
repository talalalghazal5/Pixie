import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pixie/controllers/main_controller.dart';
import 'package:pixie/controllers/settings_controller.dart';

///TODO: MAKE ACTIVE ICON SOLID AND THE OTHER ARE OUTLINED.
class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 4, right: 4),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Obx(
            () => GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Theme.of(context).colorScheme.inversePrimary,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInCubic,
              tabBackgroundColor: Colors.grey[100]!,
              color: Theme.of(context).colorScheme.inversePrimary,
              tabMargin: const EdgeInsets.all(5),
              tabs: [
                GButton(
                  icon: FontAwesomeIcons.house,
                  iconActiveColor: Theme.of(context).colorScheme.tertiary,
                  text: 'Home',
                  gap: 13,
                  backgroundColor: const Color(0xff0000ff).withAlpha(40),
                  textStyle:  TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'space',
                  ),
                ),
                GButton(
                  icon: FontAwesomeIcons.magnifyingGlass,
                  text: 'Search',
                  iconActiveColor: Colors.cyan[800],
                  backgroundColor: const Color(0xFFB2EBF2).withAlpha(70),
                  textStyle: TextStyle(
                    color: Colors.cyan[800],
                    fontWeight: FontWeight.bold,
                    fontFamily: 'space',
                  ),
                ),
                GButton(
                  icon: FontAwesomeIcons.heart,
                  text: 'Favorites',
                  iconActiveColor: const Color(0xffff0000).withAlpha(200),
                  backgroundColor: const Color(0xffff0000).withAlpha(30),
                  textStyle: TextStyle(
                    color: const Color(0xffff0000).withAlpha(200),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'space',
                  ),
                ),
                GButton(
                  icon: FontAwesomeIcons.gear,
                  text: 'Settings',
                  iconActiveColor: const Color(0xffFfa500),
                  backgroundColor: const Color(0xffFfa500).withAlpha(40),
                  textStyle: const TextStyle(
                    color: Color(0xffFfa500),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'space',
                  ),
                ),
              ],
              selectedIndex: mainController.navIndex.value,
              onTabChange: (value) => mainController.onTabTapped(value),
            ),
          ),
        ),
      ),
    );
  }
}
