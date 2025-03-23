import 'dart:io';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pixie/data/models/photo.dart';
import 'package:pixie/services/home_page_service.dart';

class PhotosController extends GetxController {
  final HomePageService homePageService = HomePageService();
  final box = Hive.box<Photo>('favorites');
  final _photos = <Photo>[].obs;
  final _resultPhotos = <Photo>[].obs;
  final _favorites = <Photo>[].obs;
  final _ids = <String>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  List<Photo> get photos => _photos;
  List<Photo> get results => _resultPhotos;
  List<Photo> get favorites => getFavorites().isEmpty ? [] : getFavorites();
  List<String> get ids => _ids;

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

  set favorites(List<Photo> photolist) {
    if (photolist.isNotEmpty) {
      _favorites.addAll(photolist);
    }
    update();
  }

  void addToIds(String id) {
    ids.add(id);
    update();
  }

  void removeFromIds(String id) {
    ids.remove(id);
    update();
  }

  void addToFaves(Photo photo) async {
    try {
      if (!favorites.contains(photo)) {
        favorites.add(photo);
        addToIds(photo.id.toString());
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
    removeFromIds(photo.id.toString());
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


  // HIVE FUNCTIONS:
  void addToFavorites(Photo photo) {
    photo.liked = true;
    box.put(photo.id.toString(), photo);
    update();
  }

  void removeFromFavorites(Photo photo) {
    photo.liked = false;
    box.delete(photo.id.toString());
    update();
  }

  List<Photo> getFavorites() {
    return box.values.toList();
  }
}
