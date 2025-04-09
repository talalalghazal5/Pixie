import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pixie/UI/components/error_loading.dart';
import 'package:pixie/UI/components/pixie_logo_text.dart';
import 'package:pixie/UI/view/preview_page.dart';
import 'package:pixie/bindings/network_exception.dart';
import 'package:pixie/controllers/color_controller.dart';
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
      stalePeriod: const Duration(days: 1),
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    controller.loadPhotos();
                  });
                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PreviewPage(
                                    photo: photo,
                                  ),
                                ),
                              );
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
                                placeholder: (context, url) => Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(ColorController()
                                                .convertColor(photo.avgColor))
                                            .withAlpha(200),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    const PixieLogoText(
                                      fontSize: 30,
                                    )
                                  ],
                                ),
                                errorWidget: (context, error, stackTrace) =>
                                    const Center(
                                  child: Icon(
                                    FontAwesomeIcons.exclamation,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          loadMorePhotos(controller);
                        },
                        height: 20,
                        child: isLoading
                            ? Center(
                                child: Lottie.asset(
                                  'assets/animations/Animation - 1737652724809 (1).json',
                                  width: 100,
                                ),
                              )
                            : Text(
                                'loadMoreCTA'.tr,
                                style: TextStyle(
                                  fontFamilyFallback: const ['sfArabic'],
                                  fontFamily: 'space',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          if (controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: ErrorLoading(
                onPressed: () {
                  controller.loadPhotos();
                  setState(() {});
                },
                messageText: controller.errorMessage.value,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  void loadMorePhotos(PhotosController controller) async {
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
    } on NetworkException {
      ScaffoldMessenger.of(context.mounted ? context : context).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.horizontal,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Text(
            'errorMessage'.tr,
            style: TextStyle(
              fontFamily: 'space',
              fontFamilyFallback: const ['sfArabic'],
              color: Theme.of(
                context.mounted ? context : context,
              ).colorScheme.surface,
            ),
          ),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
