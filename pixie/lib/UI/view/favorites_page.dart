import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pixie/UI/view/preview_page.dart';
import 'package:pixie/controllers/photos_controller.dart';
import 'package:pixie/data/models/photo.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with SingleTickerProviderStateMixin {
  PhotosController photosController = Get.find<PhotosController>();
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
  @override
  void initState() {
    super.initState();
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

          if (controller.favorites.isNotEmpty) {
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
                      itemCount: controller.favorites.length,
                      itemBuilder: (context, index) {
                        Photo photo = controller.favorites[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => PreviewPage(
                                photo: photo,
                              ),
                              transition: Transition.cupertino,
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
                              imageUrl: photo.src.portrait!,
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
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (controller.favorites.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.heartCrack,
                    size: 100,
                  ),
                  Text(
                    'Nothing here',
                    style: TextStyle(fontFamily: 'space', fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
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
