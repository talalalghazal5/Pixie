import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pixie/controllers/settings_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String langValue = 'ar';
  SettingsController settingsController = Get.find<SettingsController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Center(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Settings',
            style: TextStyle(
              fontFamily: 'space',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () {
              return SwitchListTile(
                value: settingsController.isDarkMode.value,
                onChanged: (value) {
                  setState(() {
                    settingsController.toggleThemeMode();
                  });
                  // Get.changeThemeMode(Get.isDarkMode ? ThemeMode.dark : Theme)
                },
                title: Text(
                  'Dark mode',
                  style: TextStyle(
                    fontFamily: 'space',
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                tileColor:
                    Theme.of(context).colorScheme.primary.withAlpha(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withAlpha(50),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Language',
                  style: TextStyle(
                    fontFamily: 'space',
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                DropdownButton(
                  value: langValue,
                  items: [
                    DropdownMenuItem<String>(
                      value: 'en',
                      child: Text(
                        'English',
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .inversePrimary),
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: 'ar',
                      child: Text(
                        'Arabic',
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .inversePrimary),
                      ),
                    ),
                  ],
                  iconEnabledColor:
                      Theme.of(context).colorScheme.inversePrimary,
                  underline: Container(
                    height: 0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  style: const TextStyle(
                    fontFamily: 'space',
                  ),
                  onChanged: (value) {
                    setState(() {
                      langValue = value!;
                    });
                  },
                )
              ],
            ),
          ),
          const Spacer(
            flex: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Made by: Eng. Talal Alghazal',
                  style: TextStyle(
                    fontFamily: 'space',
                    fontSize: 15,
                    color: Theme.of(context)
                        .colorScheme
                        .inversePrimary
                        .withAlpha(100),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.copyright,
                      color: Theme.of(context)
                          .colorScheme
                          .inversePrimary
                          .withAlpha(100),
                      size: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Copyrights reserved',
                      style: TextStyle(
                        fontFamily: 'space',
                        fontSize: 14,
                        color: Theme.of(context)
                            .colorScheme
                            .inversePrimary
                            .withAlpha(100),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Powered by',
                  style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context)
                          .colorScheme
                          .inversePrimary
                          .withAlpha(100)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                  settingsController.isDarkMode.value
                      ? 'assets/images/pexels_logo_white.png'
                      : 'assets/images/pexels_logo_black.png',
                  width: 60,
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
