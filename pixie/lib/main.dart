import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixie/UI/view/loading_page.dart';
import 'package:pixie/UI/view/main_page.dart';
import 'package:pixie/bindings/my_bindings.dart';
import 'package:pixie/controllers/photos_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences preferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: MyBindings(),
      initialRoute: '/loadingPage',
      getPages: [
        GetPage(
          name: '/mainPage',
          page: () => const MainPage(),
        ),
        GetPage(
          name: '/loadingPage',
          page: () => const LoadingPage(),
        ),
      ],
      // home: const HomePage(),
    );
  }
}
