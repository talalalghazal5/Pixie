import 'dart:io';

import 'package:get/get.dart';
import 'package:pixie/data/models/photo.dart';
import 'package:pixie/services/home_page_service.dart';

class PhotosController extends GetxController {
  final _photos = <Photo>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  List<Photo> get photos => _photos;

  set photos(List<Photo> photolist) {
    if (photolist.isNotEmpty) {
      _photos.addAll(photolist);
    }
    update();
  }

  void loadPhotos() async {
    try {
      isLoading(true);
      photos = await HomePageService().getCuratedPhotos();
    } on SocketException {
      errorMessage.value = 'No internet connection';
    } catch (e) {
      errorMessage.value = 'Error occured while fetching photos';
    } finally {
      isLoading(false);
      update();
    }
  }
}
