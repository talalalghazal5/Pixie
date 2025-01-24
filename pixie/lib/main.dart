import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixie/UI/view/main_page.dart';
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
      initialRoute: '/mainPage',
      getPages: [
        GetPage(name: '/mainPage', page: () => const MainPage(),),
      ],
      // home: const HomePage(),
    );
  }
}
