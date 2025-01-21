import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  int navIndex = 0;
  PageController pageController = PageController();

  void onPageChanged(int index) {
    navIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
    update();
  }

  void onTabTapped(int index) {
    navIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
    update();
  }
}
