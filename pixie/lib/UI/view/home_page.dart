import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:pixie/controllers/main_controller.dart';
import 'package:pixie/data/models/photo.dart';
import 'package:pixie/main.dart';
import 'package:pixie/services/home_page_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  int pageNumber = 1;
  late Future<List<Photo>> photos;
  final ScrollController scrollController = ScrollController();
  static final CacheManager cacheManager = CacheManager(Config(
    'customCacheKey',
    stalePeriod: Duration(days: 3),
    maxNrOfCacheObjects: 100,
  ));
  @override
  void initState() {
    super.initState();
    if (preferences.getString('cachedPhotos') == null) {
      photos = HomePageService().getCuratedPhotos(page: pageNumber);
    } else {
      photos = fetchPhotosFromCache();
    }
  }

  Future<List<Photo>> fetchPhotosFromCache() async {
    String cachedImages = preferences.getString('cachedPhotos') ?? '';
    List<dynamic> jsonPhotos = jsonDecode(cachedImages);
    print(jsonPhotos);
    photos =
        Future.value(jsonPhotos.map((photo) => Photo.fromJson(photo)).toList());
        return photos;
  }

  void cachePhotos() async {
    List<dynamic> jsonPhotos = await photos
        .then((value) => value.map((photo) => photo.toJson()).toList());
    preferences.setString('cachedPhotos', jsonEncode(jsonPhotos));
  }

  @override
  void dispose() {
    super.dispose();
    cachePhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: photos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset(
                  'assets/animations/Animation - 1737652724809 (1).json',
                  width: 200),
            );
          } else if (snapshot.hasError) {
            if (snapshot.error is DioException ||
                snapshot.error is SocketException) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Text('Nothing found');
          }
          List<Photo> photos = snapshot.data!;
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GridView.builder(
                    controller: scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: .6,
                    ),
                    shrinkWrap: true,
                    itemCount: photos.length,
                    itemBuilder: (context, index) {
                      Photo photo = snapshot.data![index];
                      return CupertinoContextMenu(
                        enableHapticFeedback: true,
                        actions: [
                          CupertinoContextMenuAction(
                            onPressed: () {},
                            isDefaultAction: true,
                            trailingIcon: FontAwesomeIcons.images,
                            child: Text(
                              'Set as...',
                              style: TextStyle(fontFamily: 'space'),
                            ),
                          ),
                          CupertinoContextMenuAction(
                              onPressed: () => Navigator.pop(context),
                              trailingIcon: FontAwesomeIcons.ban,
                              isDestructiveAction: true,
                              child: Text(
                                'Cancel',
                                style: TextStyle(fontFamily: 'space'),
                              )),
                        ],
                        child: Container(
                          height: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: CachedNetworkImage(
                            key: UniqueKey(),
                            cacheManager: cacheManager,
                            fit: BoxFit.cover,
                            imageUrl: photo.src.large!,
                            placeholder: (context, url) => Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffeeeeee),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            errorWidget: (context, error, stackTrace) =>
                                const Center(
                              child: Icon(
                                  CupertinoIcons.exclamationmark_circle_fill),
                            ),
                          ),
                        ),
                      );
                    }),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    pageNumber++;
                    List<Photo> newPhotos = await HomePageService()
                        .getCuratedPhotos(page: pageNumber, perPage: 40);
                    setState(() {
                      photos.addAll(newPhotos);
                      isLoading = false;
                    });
                  },
                  height: 20,
                  child: isLoading
                      ? Center(
                          child: Lottie.asset(
                              'assets/animations/Animation - 1737652724809 (1).json',
                              width: 100),
                        )
                      : Text(
                          'Load more',
                          style: TextStyle(fontFamily: 'space'),
                        ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
