import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixie/UI/components/navbar.dart';
import 'package:pixie/UI/view/favorites_page.dart';
import 'package:pixie/UI/view/home_page.dart';
import 'package:pixie/UI/view/search_page.dart';
import 'package:pixie/UI/view/settings_page.dart';
import 'package:pixie/controllers/main_controller.dart';
import 'package:pixie/controllers/photos_controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int navIndex = 0;
  List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    FavoritesPage(),
    SettingsPage(),
  ];
  PhotosController photosController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 5,
        elevation: 10,
        forceMaterialTransparency: true,
        title: Text(
          'Pixie',
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontFamily: 'yesterday',
            fontFamilyFallback: const ['sfArabic'],
            fontSize: 40,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
      body: PageView(
        controller: mainController.pageController,
        onPageChanged: (value) => mainController.onPageChanged(value),
        children: pages,
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
