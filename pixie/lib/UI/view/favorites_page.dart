import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pixie/UI/components/pixie_logo_text.dart';
import 'package:pixie/UI/view/preview_page.dart';
import 'package:pixie/controllers/color_controller.dart';
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

  Future<void> refresh() async {
    setState(() {
      photosController.getFavorites();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: Scaffold(
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
                  physics: const AlwaysScrollableScrollPhysics(),
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
                                imageUrl: photo.src.portrait!,
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
                                    Stack(
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
                                    const Center(
                                      child: FaIcon(
                                          FontAwesomeIcons.triangleExclamation),
                                    ),
                                  ],
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
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/empty.png',
                      width: 200,
                      isAntiAlias: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'emptyPageLabel'.tr,
                      style: TextStyle(
                          fontFamily: 'space',
                          fontFamilyFallback: const ['sfArabic'],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inversePrimary),
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
                      style: const TextStyle(
                        fontFamily: 'space',
                        fontFamilyFallback: ['sfArabic'],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
