import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pixie/UI/components/wallpaper_location_dialog_contents.dart';
import 'package:pixie/controllers/color_controller.dart';
import 'package:pixie/data/models/photo.dart';
import 'package:pixie/main.dart';
import 'package:pixie/services/home_page_service.dart';
import 'package:pixie/services/permssion_service.dart';
import 'package:wallpaper_manager_plus/wallpaper_manager_plus.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key, required this.photo});
  final Photo photo;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  int selectedLocation = WallpaperManagerPlus.homeScreen;


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
                progressIndicatorBuilder: (context, url, progress) => Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Color(
                      ColorController().convertColor(widget.photo.avgColor),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error occured while getting the image',
                      style: TextStyle(fontFamily: 'space'),
                    ),
                  ],
                ),
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
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const FaIcon(
                      FontAwesomeIcons.chevronLeft,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ),
                ),
              )),
          Positioned(
            bottom: 0,
            child: Stack(
              alignment: Alignment.centerLeft,
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
                      height: 140,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        transform: GradientRotation(-pi / 2),
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Taken by:',
                        style: TextStyle(
                            color: Colors.white70, fontFamily: 'space'),
                      ),
                      Text(
                        widget.photo.photographer,
                        style: const TextStyle(
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
          Positioned(
            bottom: 10,
            right: 10,
            child: Row(
              children: [
                ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: IconButton(
                      onPressed: () {
                        savePhoto();
                      },
                      icon: const LineIcon(
                        LineIcons.download,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: TextButton(
                      style: const ButtonStyle(
                          padding: WidgetStatePropertyAll(
                              EdgeInsetsDirectional.symmetric(horizontal: 20))),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => SizedBox(
                            height: 250,
                            child: buildWallpaperLocationDialog(),
                          ),
                        );
                      },
                      child: const Text(
                        'Set as..',
                        style: TextStyle(
                          fontFamily: 'space',
                          color: Colors.white,
                        ),
                      ),
                    ),
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
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Downloading photo...',
          style: TextStyle(fontFamily: 'space'),
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
          content: const Text(
            'Applied Wallpaper',
            style: TextStyle(fontFamily: 'space', fontWeight: FontWeight.w700),
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
      title: const Text('Choose where to apply:',
          style: TextStyle(fontFamily: 'space')),
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
            child: const Text(
              'Cancel',
              style: TextStyle(fontFamily: 'space'),
            )),
        TextButton(
          onPressed: () {
            setAsWallpaper(
              widget.photo.src.original!,
              selectedLocation,
            );
            Navigator.pop(context);
          },
          child: const Text(
            'Save',
            style: TextStyle(
              fontFamily: 'space',
            ),
          ),
        ),
      ],
    );
  }
}
