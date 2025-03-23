import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pixie/UI/view/preview_page.dart';
import 'package:pixie/controllers/photos_controller.dart';
import 'package:pixie/data/models/photo.dart';
import 'package:pixie/services/home_page_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _TestHomePageState();
}

class _TestHomePageState extends State<HomePage> {
  bool isLoading = false;
  ScrollController scrollController = ScrollController();
  int pageNumber = 1;
  static final CacheManager cacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 3),
      maxNrOfCacheObjects: 100,
    ),
  );

  void refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PhotosController>(
        builder: (controller) {
          if (controller.isLoading.value) {
            return Center(
              child: Lottie.asset(
                'assets/animations/Animation - 1737652724809 (1).json',
                width: 200,
              ),
            );
          }

          if (controller.photos.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
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
                        itemCount: controller.photos.length,
                        itemBuilder: (context, index) {
                          Photo photo = controller.photos[index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => PreviewPage(
                                    photo: photo,
                                  ), transition: Transition.cupertino,);
                            },
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
                                      CupertinoIcons.exclamationmark_circle_fill), /// TODO: CHANGE THIS ICON WHEN FIXING BUGS.
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
                        try {
                          pageNumber++;
                          List<Photo> newPhotos = await HomePageService()
                              .getCuratedPhotos(page: pageNumber, perPage: 40);
                          setState(() {
                            controller.photos = newPhotos;
                          });
                        } on SocketException {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'No internet connection, please try again later',
                                style: TextStyle(fontFamily: 'space'),
                              ),
                            ),
                          );
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      height: 20,
                      child: isLoading
                          ? Center(
                              child: Lottie.asset(
                                'assets/animations/Animation - 1737652724809 (1).json',
                                width: 100,
                              ),
                            )
                          : const Text(
                              'Load more',
                              style: TextStyle(fontFamily: 'space'),
                            ),
                    )
                  ],
                ),
              ),
            );
          }
          if (controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.errorMessage.value,
                    style: const TextStyle(fontFamily: 'space'),
                  ),
                  const SizedBox(height: 15,),
                  MaterialButton(
                    onPressed: () {
                      controller.loadPhotos();
                      setState(() {
                        
                      });
                    },
                    color: const Color(0xff0000ff).withAlpha(50),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Retry',
                      style: TextStyle(
                        fontFamily: 'spaceMedium',
                        color: const Color(0xff0000ff).withAlpha(200),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
