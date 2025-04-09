import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pixie/UI/themes/dark_theme.dart';
import 'package:pixie/UI/themes/light_theme.dart';
import 'package:pixie/UI/view/loading_page.dart';
import 'package:pixie/UI/view/main_page.dart';
import 'package:pixie/bindings/my_bindings.dart';
import 'package:pixie/controllers/my_locale_controller.dart';
import 'package:pixie/controllers/settings_controller.dart';
import 'package:pixie/data/models/photo.dart';
import 'package:pixie/data/models/photo_src.dart';
import 'package:pixie/localization/my_locale.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences preferences;
late String apiKey;
late String baseUrl;
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  apiKey = dotenv.env['API_KEY'] ?? '';
  baseUrl = dotenv.env['BASE_URL'] ?? '';
  preferences = await SharedPreferences.getInstance();
  await Hive.initFlutter();
  Hive.registerAdapter(PhotoAdapter());
  Hive.registerAdapter(PhotoSrcAdapter());
  await Hive.openBox<Photo>('favorites');
  Get.put(SettingsController());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    MyLocaleController myLocaleController = Get.put(MyLocaleController());
    return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: MyBindings(),
          initialRoute: '/loadingPage',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: SettingsController().isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
          translations: MyLocale(),
          locale: myLocaleController.locale,
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
        );
  }
}
