import 'dart:ui';

import 'package:get/get.dart';
import 'package:pixie/main.dart';

class MyLocaleController extends GetxController {
  Locale locale = preferences.getString('language') == null ? Get.deviceLocale! : Locale(preferences.getString('language')!);
  
  void changeLanguage(String languageCode) {
    Locale currentlocale = Locale(languageCode);
    preferences.setString('language', languageCode);
    Get.updateLocale(currentlocale);
    update();
  }
}