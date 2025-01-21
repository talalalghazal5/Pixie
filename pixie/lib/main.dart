import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixie/UI/view/main_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/mainPage',
      getPages: [
        GetPage(name: '/mainPage', page: () => const MainPage(),),
      ],
      // home: const HomePage(),
    );
  }
}
