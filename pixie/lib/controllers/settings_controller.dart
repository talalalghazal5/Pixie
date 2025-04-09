import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixie/main.dart';

class SettingsController extends GetxController {
  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadTheme(); // to load the theme when the app starts.
  }

  // to change the theme mode.
  void toggleThemeMode() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    saveTheme(isDarkMode.value); // this is for saving the selection of the theme mode in order to cache it.
    update();
  }

  void saveTheme(bool isDark) {
    preferences.setBool('darkMode', isDark); // caching the preference of the theme mode.
    update();
  }

  void loadTheme() {
    isDarkMode.value = preferences.getBool('darkMode') ?? false;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light); // we changed the theme mode here to load the last mode selected.
    update();
  }
}
