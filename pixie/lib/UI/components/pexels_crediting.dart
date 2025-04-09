import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pixie/controllers/settings_controller.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PexelsCrediting extends StatelessWidget {
  const PexelsCrediting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'poweredBy'.tr,
            style: TextStyle(
              fontFamilyFallback: ['sfArabic'],
                fontSize: 11,
                color:
                    Theme.of(context).colorScheme.inversePrimary.withAlpha(100)),
          ),
          const SizedBox(
            width: 10,
          ),
          GetBuilder<SettingsController>(
            builder: (controller) {
              return GestureDetector(
                onTap: () => launchUrlString("https://pexels.com"),
                child: Image.asset(
                  controller.isDarkMode.value
                      ? 'assets/images/pexels_logo_white.png'
                      : 'assets/images/pexels_logo_black.png',
                  width: 60,
                ),
              );
            }
          ),
          const SizedBox(width: 5,),
          Icon(Icons.arrow_outward_rounded, size: 20  , color: Theme.of(context).colorScheme.inversePrimary.withAlpha(100),),
        ],
      ),
    );
  }
}
