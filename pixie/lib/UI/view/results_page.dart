import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pixie/UI/components/error_loading.dart';
import 'package:pixie/UI/components/pixie_logo_text.dart';
import 'package:pixie/UI/view/preview_page.dart';
import 'package:pixie/controllers/color_controller.dart';
import 'package:pixie/controllers/photos_controller.dart';
import 'package:pixie/data/models/photo.dart';
import 'package:pixie/data/models/search_category.dart';
import 'package:pixie/services/home_page_service.dart';

// ignore: must_be_immutable
class ResultsPage extends StatefulWidget {
  ResultsPage({super.key, this.query, this.category});
  String? query;
  SearchCategory? category;
  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
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
    photosController.loadResults(query: widget.category?.value ?? widget.query);
  }

  @override
  void dispose() {
    super.dispose();
    photosController.results.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${'resultHeaderTitle'.tr}'
          ' "${widget.category?.name!.tr ?? widget.query!.trim()}"',
        ),
        titleTextStyle: TextStyle(
            fontFamily: 'space',
            fontFamilyFallback: const ['sfArabic'],
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.inversePrimary,
            fontSize: 17),
        surfaceTintColor: Colors.blue,
      ),
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

          if (controller.results.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    controller.loadResults();
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
                          itemCount: controller.results.length,
                          itemBuilder: (context, index) {
                            Photo photo = controller.results[index];
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      const Center(
                                        child: FaIcon(
                                          FontAwesomeIcons.triangleExclamation,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
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
                                style: const TextStyle(
                                  fontFamily: 'space',
                                  fontFamilyFallback: ['sfArabic'],
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else if (controller.results.isEmpty) {
            return Center(
              child: Text(
                '${'noResultsFound'.tr} "${widget.query!.trim()}"',
                style: TextStyle(
                    fontFamily: 'space',
                    fontFamilyFallback: const ['sfArabic'],
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
            );
          }
          if (controller.errorMessage.value.isNotEmpty) {
            return Center(
                child: ErrorLoading(
              onPressed: () {
                controller.loadResults(query: widget.query);
                setState(() {});
              },
              messageText: controller.errorMessage.value,
            ));
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
      List<Photo> newPhotos = await HomePageService().searchPhotos(
          page: pageNumber, query: widget.category?.value ?? widget.query);
      setState(() {
        controller.results = newPhotos;
      });
    } on SocketException {
      ScaffoldMessenger.of(context.mounted ? context : context).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.horizontal,
          content: Text(
            'errorMessage'.tr,
            style: const TextStyle(
              fontFamily: 'space',
              fontFamilyFallback: ['sfArabic'],
            ),
          ),
        ),
      );
    } on DioException catch (e) {
      ScaffoldMessenger.of(context.mounted ? context : context).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.horizontal,
          content: Text(
            e.message!,
            style: const TextStyle(
              fontFamily: 'space',
              fontFamilyFallback: ['sfArabic'],
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
