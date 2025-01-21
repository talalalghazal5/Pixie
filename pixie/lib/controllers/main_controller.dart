import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  RxInt navIndex = 0.obs;
  PageController pageController = PageController();

  void onPageChanged(int index) {
    navIndex.value = index;
  }

  void onTabTapped(int index) {
    navIndex.value = index;
    pageController.animateToPage(
      navIndex.value,
      duration: const Duration(milliseconds: 50),
      curve: Curves.ease,
    );
  }
}
