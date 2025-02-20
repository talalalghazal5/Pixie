import 'dart:io';

import 'package:get/get.dart';
import 'package:pixie/data/models/photo.dart';
import 'package:pixie/services/home_page_service.dart';

class PhotosController extends GetxController {
  final HomePageService homePageService = HomePageService();
  final _photos = <Photo>[].obs;
  final _resultPhotos = <Photo>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  List<Photo> get photos => _photos;
  List<Photo> get results => _resultPhotos;

  set photos(List<Photo> photolist) {
    if (photolist.isNotEmpty) {
      _photos.addAll(photolist);
    }
    update();
  }

  set results(List<Photo> photolist) {
    if (photolist.isNotEmpty) {
      _resultPhotos.addAll(photolist);
    }
    update();
  }

  void loadPhotos() async {
    try {
      isLoading(true);
      photos = await homePageService.getCuratedPhotos();
    } on SocketException {
      errorMessage.value = 'No internet connection';
    } catch (e) {
      errorMessage.value = 'Error occured while fetching photos';
    } finally {
      isLoading(false);
      update();
    }
  }

  void loadResults({String? query, int page = 1, int perPage = 20}) async {
    try {
      isLoading(true);
      results = await homePageService.searchPhotos(query: query, page: page, perPage: perPage);
    } on SocketException {
      errorMessage.value = 'No internet connection';
    } catch (e) {
      errorMessage.value = 'Error occured';
    } finally {
      isLoading(false);
      update();
    }
  }
}
