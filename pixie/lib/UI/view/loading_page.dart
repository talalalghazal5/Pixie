import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixie/UI/components/pexels_crediting.dart';
import 'package:pixie/UI/view/main_page.dart';
import 'package:pixie/controllers/photos_controller.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  PhotosController photosController = Get.find<PhotosController>();

  @override
  void initState() {
    super.initState();
    photosController.loadPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: GetBuilder<PhotosController>(
            init: PhotosController(),
            builder: (controller) {
              if (controller.isLoading.value) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const CircularProgressIndicator(),
                    const SizedBox(
                      height: 14,
                    ),
                    Text(
                      'waitingMessage'.tr,
                      style: const TextStyle(
                        fontFamily: 'space',
                        fontSize: 15,
                      ),
                    ),
                    const Spacer(),
                    const PexelsCrediting()
                  ],
                );
              }
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => Get.off(
                  () => const MainPage(),
                  transition: Transition.leftToRightWithFade,
                ),
              );
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
