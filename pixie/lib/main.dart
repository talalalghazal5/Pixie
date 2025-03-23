
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pixie/UI/view/loading_page.dart';
import 'package:pixie/UI/view/main_page.dart';
import 'package:pixie/bindings/my_api_key.dart';
import 'package:pixie/bindings/my_bindings.dart';
import 'package:pixie/data/models/photo.dart';
import 'package:pixie/data/models/photo_src.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences preferences;
final String apiKey = MyApiKey.apiKey;
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  await Hive.initFlutter();
  Hive.registerAdapter(PhotoAdapter());
  Hive.registerAdapter(PhotoSrcAdapter());
  await Hive.openBox<Photo>('favorites');
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
