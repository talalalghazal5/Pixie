// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
              'page': page,
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
      // ignore: duplicate_ignore
      // ignore: avoid_print
      print(response.statusCode);
      throw {'message': response.statusMessage};
    } on DioException catch (e) {
      throw e.error!;
    }
  }

  Future<void> downloadPhoto({
    required int imageId,
    required String imageUrl,
    required BuildContext context,
  }) async {
    try {
      var downloadsPath = Directory(
        '/storage/emulated/0/DCIM/Pixie',
      );
      var imagePath = '${downloadsPath.path}/$imageId.png';
      if (!downloadsPath.existsSync()) {
        downloadsPath.createSync(recursive: true);
      }
      var response = await dio.get(imageUrl,
          options: Options(responseType: ResponseType.bytes, headers: {
            'Authorization': apiKey,
          }));

      if (response.statusCode == 200) {
        var bytes = response.data;
        File file = File(imagePath);
        await file.writeAsBytes(bytes);
        if (scaffoldKey.currentContext != null) {
          ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
            SnackBar(
              dismissDirection: DismissDirection.horizontal,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.lightGreen[600],
              content: Text(
                'downloadedSuccessfullySnackbarMessage'.tr,
                style: const TextStyle(
                    fontFamily: 'space',
                    fontFamilyFallback: ['sfArabic'],
                    color: Colors.white),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          );
        }
        // Save the image to the gallery
      }
    } catch (e) {
      if (scaffoldKey.currentContext != null) {
        ScaffoldMessenger.maybeOf(scaffoldKey.currentContext!)!.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.horizontal,
            content: Text(
              'downloadFailedSnackbarMessage'.tr,
              style: TextStyle(
                fontFamilyFallback: ['sfArabic'],
                  fontFamily: 'space',
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        );
      }
      print('${e.toString()}======');
    }
  }

  Future<List<Photo>> searchPhotos(
      {String? query, int page = 1, int perPage = 20}) async {
    List<Photo> results = [];
    try {
      var response = await dio
          .get(
            '$baseUrl/search',
            queryParameters: {
              'query': query,
              'page': page,
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
        results = jsonPhotos.map((photo) => Photo.fromJson(photo)).toList();
        return results;
      }
      throw {'message': response.statusMessage};
    } on DioException catch (e) {
      throw e.message!;
    }
  }

  Future<Photo> getImageById(String id) async {
    Photo photo;
    try {
      var response = await dio
          .get(
            '$baseUrl/photos/$id',
            options: Options(
              headers: {
                'Authorization': apiKey,
              },
            ),
          )
          .timeout(const Duration(minutes: 5));
      if (response.statusCode == 200) {
        var responseBody = response.data;
        photo = Photo.fromJson(responseBody);
        return photo;
      }
      throw {'message': response.statusMessage};
    } on DioException catch (e) {
      throw e.message!;
    }
  }
}
