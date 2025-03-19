import 'dart:io';

import 'package:get/get.dart';
import 'package:pixie/data/models/photo.dart';
import 'package:pixie/services/home_page_service.dart';

class PhotosController extends GetxController {
  final HomePageService homePageService = HomePageService();
  final _photos = <Photo>[].obs;
  final _resultPhotos = <Photo>[].obs;
  final _favorites = <Photo>[].obs;
  final _ids = <String>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  List<Photo> get photos => _photos.value;
  List<Photo> get results => _resultPhotos.value;
  List<Photo> get favorites => _favorites.value;
  List<String> get ids => _ids;

  set photos(List<Photo> photolist) {
    if (photolist.isNotEmpty) {
      _photos.value.addAll(photolist);
    }
    update();
  }

  set results(List<Photo> photolist) {
    if (photolist.isNotEmpty) {
      _resultPhotos.value.addAll(photolist);
    }
    update();
  }

  set favorites(List<Photo> photolist) {
    if (photolist.isNotEmpty) {
      _favorites.value.addAll(photolist);
    }
    update();
  }

  void addToIds(Photo photo) {
    ids.add(photo.id.toString());
    update();
  }

  void removeFromIds(Photo photo) {
    ids.remove(photo.id.toString());

    update();
  }

  void addToFaves(Photo photo) async {
    try {
      if (!favorites.contains(photo)) {
        favorites.add(photo);
        addToIds(photo);
      }
      update();
    } on SocketException {
      errorMessage.value = 'No internet connection';
    } catch (e) {
      errorMessage.value = 'Error occured';
    } finally {
      update();
    }
  }

  void removeFromFaves(Photo photo) {
    favorites.removeWhere(
      (element) => element.id.toString() == photo.id.toString(),
    );
    removeFromIds(photo);
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
      results = await homePageService.searchPhotos(
        query: query,
        page: page,
        perPage: perPage,
      );
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
