import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pixie/controllers/main_controller.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 4, right: 4),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Obx(
        () => GNav(
          rippleColor: Colors.grey[300]!,
          hoverColor: Colors.grey[100]!,
          gap: 8,
          // activeColor: Theme.of(context).colorScheme.inversePrimary,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInCubic,
          tabBackgroundColor: Colors.grey[100]!,
          color: Theme.of(context).colorScheme.inversePrimary,
          tabMargin: const EdgeInsets.all(5),
          haptic: true,
          tabs: [
            GButton(
              icon: LineIcons.home,
              iconSize: 27,
              iconActiveColor: Theme.of(context).colorScheme.tertiary,
              text: 'homePageNavBarTab'.tr,
              gap: 13,
              backgroundColor: const Color(0xff0000ff).withAlpha(40),
              textStyle:  TextStyle(
                fontFamilyFallback: ['sfArabic'],
                color: Theme.of(context).colorScheme.tertiary,
                fontWeight: FontWeight.bold,
                fontFamily: 'space',
              ),
            ),
            GButton(
              icon: LineIcons.search,
              iconSize: 28,
              text: 'searchPageNavBarTab'.tr,
              iconActiveColor: Colors.cyan[800],
              backgroundColor: const Color(0xFFB2EBF2).withAlpha(70),
              textStyle: TextStyle(
                fontFamilyFallback: ['sfArabic'],
                color: Colors.cyan[800],
                fontWeight: FontWeight.bold,
                fontFamily: 'space',
              ),
            ),
            GButton(
              icon: LineIcons.heart,
              iconSize: 27,
              text: 'favoritesPageNavBarTab'.tr,
              iconActiveColor: const Color(0xFFFF0000).withAlpha(200),
              backgroundColor: const Color(0xFFFF0000).withAlpha(30),
              textStyle: TextStyle(
                fontFamilyFallback: ['sfArabic'],
                color: const Color(0xffff0000).withAlpha(200),
                fontWeight: FontWeight.bold,
                fontFamily: 'space',
              ),
            ),
            GButton(
              icon: LineIcons.bars,
              iconSize: 27,
              text: 'settingsPageNavBarTab'.tr,
              iconActiveColor: const Color(0xffFfa500),
              backgroundColor: const Color(0xffFfa500).withAlpha(40),
              textStyle: const TextStyle(
                color: Color(0xffFfa500),
                fontWeight: FontWeight.bold,
                fontFamily: 'space',
                fontFamilyFallback: ['sfArabic'],
              ),
            ),
          ],
          selectedIndex: mainController.navIndex.value,
          onTabChange: (value) => mainController.onTabTapped(value),
        ),
      ),
    );
  }
}
