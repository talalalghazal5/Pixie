import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HomePageService extends GetxService {
  /// todo: add functions to get photos from the api.
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.pexels.com/v1',
      headers: {
        'Content-type' : 'application/json',
        'Authorization' : 'Bearer gmoUMTU5wTBUcUJj9WFUY6LjfhMjMtmDZponkUkVYBjKI4kLOqhZAiDA'
      },
      connectTimeout: Duration(milliseconds: 5000),
    )
  );

  Future<void> getCuratedPhotos() async {
    // todo: get photos curated from the api.
  }
}