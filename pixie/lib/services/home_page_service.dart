import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pixie/data/models/photo.dart';
import 'package:pixie/main.dart';

class HomePageService extends GetxService {
  String baseUrl = 'https://api.pexels.com/v1';
  static final Dio dio = Dio();

  Future<List<Photo>> getCuratedPhotos({int page = 1, int perPage = 40}) async {
    List<Photo> photos;
    try {
      var response = await dio
          .get(
            '$baseUrl/curated',
            queryParameters: {
              'page' : page,
              'per_page': perPage,
            },
            options: Options(
              headers: {
                'Authorization': apiKey,
              },
            ),
          )
          .timeout(const Duration(minutes: 5));

      if (response.statusCode == 200) {
        var responseBody = response.data;
        List<dynamic> jsonPhotos = responseBody['photos'];
        // await preferences.setString('cachedPhotos', jsonEncode(jsonPhotos)); // caching the images when fetching them.
        photos = jsonPhotos.map((photo) => Photo.fromJson(photo)).toList();
        return photos;
      }
      // ignore: avoid_print
      print(response.statusCode);
      throw {'message': response.statusMessage};
    } on DioException catch (e) {
      throw e.error!;
    }
  }
}
