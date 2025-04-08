import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pixie/UI/components/error_loading.dart';
import 'package:pixie/UI/components/wallpaper_location_dialog_contents.dart';
import 'package:pixie/controllers/color_controller.dart';
import 'package:pixie/controllers/my_locale_controller.dart';
import 'package:pixie/controllers/photos_controller.dart';
import 'package:pixie/data/models/photo.dart';
import 'package:pixie/main.dart';
import 'package:pixie/services/home_page_service.dart';
import 'package:pixie/services/permssion_service.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wallpaper_manager_plus/wallpaper_manager_plus.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key, required this.photo});
  final Photo photo;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  int selectedLocation = WallpaperManagerPlus.homeScreen;
  PhotosController photosController = Get.find<PhotosController>();
  @override
  Widget build(BuildContext context) {
    print(ColorController().convertColor(widget.photo.avgColor));
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Hero(
            tag: widget.photo.src.portrait!,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: CachedNetworkImage(
                imageUrl: widget.photo.src.original!,
                progressIndicatorBuilder: (context, url, progress) => Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: Color(
                          ColorController().convertColor(widget.photo.avgColor),
                        ),
                      ),
                    ),
                    // TweenAnimationBuilder(tween: Tween<double>(begin: 0, end: progress.totalSize!.toDouble()), duration: Duration(seconds: 2), builder: (context, value, child) => CircularProgressIndicator(value: value,),)
                  ],
                ),
                errorWidget: (context, url, error) =>
                    Stack(alignment: Alignment.center, children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Color(
                      ColorController().convertColor(widget.photo.avgColor),
                    ),
                  ),
                  ErrorLoading(
                    onPressed: () => setState(() {}),
                    messageText: "errorFetchingPhotoMessage".tr,
                  )
                ]),
                placeholderFadeInDuration: const Duration(milliseconds: 0),
                fadeInCurve: Curves.linear,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: ClipOval(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context)
                            .colorScheme
                            .surface
                            .withAlpha(100),
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.chevronLeft,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  )),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: const [0.1, 1],
                        colors: [Colors.black, Colors.black.withOpacity(0)],
                      ).createShader(rect);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.black, Colors.transparent],
                          transform: GradientRotation(-pi / 2),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 14,
                  left: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'takenBy'.tr,
                          style: TextStyle(
                            color: Colors.white.withAlpha(150),
                            fontFamily: 'space',
                          ),
                        ),
                        GestureDetector(
                          onTap: () => launchUrlString(
                            'https://www.pexels.com/@${widget.photo.photographerId}',
                          ),
                          child: Row(
                            textDirection:
                                MyLocaleController().locale.languageCode == "en"
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.squareArrowUpRight,
                                size: 15,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.photo.photographer,
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 18,
                                  fontFamily: 'spaceBold',
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: IconButton(
                            padding: const EdgeInsets.all(13),
                            iconSize: 25,
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  Theme.of(context)
                                      .colorScheme
                                      .surface
                                      .withAlpha(100)),
                              iconColor: WidgetStatePropertyAll(
                                  Theme.of(context).colorScheme.inversePrimary),
                            ),
                            onPressed: () {
                              if (!widget.photo.liked!) {
                                photosController.addToFavorites(widget.photo);
                                widget.photo.liked = true;
                                setState(() {});
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    dismissDirection:
                                        DismissDirection.horizontal,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.surface,
                                    content: Text(
                                      'favoriteAdditionSnackbarMessage'.tr,
                                      style: TextStyle(
                                          fontFamily: 'space',
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 20),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                photosController
                                    .removeFromFavorites(widget.photo);
                                widget.photo.liked = false;
                                setState(() {});
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    dismissDirection:
                                        DismissDirection.horizontal,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.surface,
                                    content: Text(
                                      'favoriteRemovalSnackbarMessage'.tr,
                                      style: TextStyle(
                                        fontFamily: 'space',
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 20),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            icon: Center(
                              child: FaIcon(
                                widget.photo.liked!
                                    ? LineIcons.heartAlt
                                    : LineIcons.heart,
                                color: widget.photo.liked!
                                    ? Colors.red[400]
                                    : Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: IconButton(
                            onPressed: () {
                              savePhoto();
                            },
                            iconSize: 25,
                            padding: const EdgeInsets.all(13),
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context)
                                    .colorScheme
                                    .surface
                                    .withAlpha(100),
                              ),
                              iconColor: WidgetStatePropertyAll(
                                Theme.of(context).colorScheme.inversePrimary,
                              ),
                            ),
                            icon: const LineIcon(
                              LineIcons.download,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => SizedBox(
                                  height: 250,
                                  child: buildWallpaperLocationDialog(),
                                ),
                              );
                            },
                            iconSize: 25,
                            padding: const EdgeInsets.all(13),
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context)
                                    .colorScheme
                                    .surface
                                    .withAlpha(100),
                              ),
                              iconColor: WidgetStatePropertyAll(
                                Theme.of(context).colorScheme.inversePrimary,
                              ),
                            ),
                            icon: const LineIcon(
                              LineIcons.paintRoller,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void savePhoto() async {
    var status = await PermissionService().requestPermissions();
    ScaffoldMessenger.of(context.mounted ? context : context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.horizontal,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Text(
          'downloadStartedSnackbarMessage'.tr,
          // ignore: use_build_context_synchronously
          style: TextStyle(
              fontFamily: 'space',
              color: Theme.of(context).colorScheme.inversePrimary),
        ),
      ),
    );
    if (status == PermissionStatus.granted) {
      HomePageService().downloadPhoto(
        imageId: widget.photo.id,
        imageUrl: widget.photo.src.original!,
        context: context.mounted ? context : context,
      );
    }
  }

  void setAsWallpaper(String url, int location) async {
    try {
      File imageFile = await DefaultCacheManager().getSingleFile(url);
      WallpaperManagerPlus().setWallpaper(
        imageFile,
        location,
      );
      ScaffoldMessenger.of(context.mounted ? context : context).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.horizontal,
          content: Text(
            'appliedWallpaperSnackbarMessage'.tr,
            style: const TextStyle(
              fontFamily: 'space',
            ),
          ),
          backgroundColor: Colors.lightGreen[700],
          behavior: SnackBarBehavior.floating,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      );
    } on Exception catch (e) {
      e.toString();
    }
  }

  Widget buildWallpaperLocationDialog() {
    return AlertDialog(
      title: Text('dialogTitle'.tr,
          style: TextStyle(
              fontFamily: 'space',
              color: Theme.of(context).colorScheme.inversePrimary)),
      content: WallpaperLocationDialogContents(
        onValueChanged: (value) {
          setState(() {
            selectedLocation = value;
          });
        },
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'cancelCTA'.tr,
              style: TextStyle(
                  fontFamily: 'space',
                  color: Theme.of(context)
                      .colorScheme
                      .inversePrimary
                      .withAlpha(190),
                  fontWeight: FontWeight.w600),
            )),
        TextButton(
          onPressed: () {
            setAsWallpaper(
              widget.photo.src.original!,
              selectedLocation,
            );
            Navigator.pop(context);
          },
          child: Text(
            'saveCTA'.tr,
            style: TextStyle(
                fontFamily: 'space',
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
