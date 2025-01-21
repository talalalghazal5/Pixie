import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pixie/UI/components/navbar.dart';
import 'package:pixie/UI/view/favorites_page.dart';
import 'package:pixie/UI/view/home_page.dart';
import 'package:pixie/UI/view/profile_page.dart';
import 'package:pixie/UI/view/search_page.dart';
import 'package:pixie/controllers/main_controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int navIndex = 0;
  List<Widget> pages = const [
    HomePage(),
    FavoritesPage(),
    SearchPage(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.put(MainController());
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: AppBar(
            forceMaterialTransparency: true,
            title: Text('Pixie', style: TextStyle(fontFamily: 'spaceSemiBold'),),
          )),
      body: PageView(
          controller: mainController.pageController,
          onPageChanged: (value) => mainController.onPageChanged(value),
          children: pages),
      bottomNavigationBar: const Navbar(),
    );
  }
}
