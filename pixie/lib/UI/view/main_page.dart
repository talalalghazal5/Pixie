import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixie/UI/components/navbar.dart';
import 'package:pixie/UI/view/favorites_page.dart';
import 'package:pixie/UI/view/home_page.dart';
import 'package:pixie/UI/view/search_page.dart';
import 'package:pixie/UI/view/settings_page.dart';
import 'package:pixie/UI/view/home_page.dart';
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
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.put(MainController());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 5,
        elevation: 10,
        forceMaterialTransparency: true,
        title: const Text(
          'Pixie',
          overflow: TextOverflow.visible,
          style: TextStyle(fontFamily: 'anything', fontSize: 40,),
        ),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('powered by', style: TextStyle(fontSize: 10, fontFamily: 'space'),),
              const SizedBox(width: 6,),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Image.asset('assets/images/pexels_logo_black.png', width: 60,),
              ),
            ],
          ),
        ],
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
