import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pixie/UI/components/error_loading.dart';
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
                        itemCount: controller.results.length,
                        itemBuilder: (context, index) {
                          Photo photo = controller.results[index];
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
                                    color: Color(ColorController()
                                            .convertColor(photo.avgColor))
                                        .withAlpha(200),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                errorWidget: (context, error, stackTrace) =>
                                    const Center(
                                  child: Icon(CupertinoIcons
                                      .exclamationmark_circle_fill),
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
                              style: const TextStyle(fontFamily: 'space'),
                            ),
                    )
                  ],
                ),
              ),
            );
          } else if (controller.results.isEmpty) {
            return Center(
              child: Text(
                '${'noResultsFound'.tr} "${widget.query!.trim()}"',
                style: TextStyle(
                    fontFamily: 'space',
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
          content: Text(
            'errorMessage'.tr,
            style: const TextStyle(fontFamily: 'space'),
          ),
        ),
      );
    } on DioException catch (e) {
      ScaffoldMessenger.of(context.mounted ? context : context).showSnackBar(
        SnackBar(
          content: Text(
            e.message!,
            style: const TextStyle(fontFamily: 'space'),
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
