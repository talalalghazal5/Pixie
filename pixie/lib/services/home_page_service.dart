// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pixie/bindings/my_api_key.dart';
import 'package:pixie/data/models/photo.dart';

class HomePageService extends GetxService {
  String baseUrl = 'https://api.pexels.com/v1';
  final String apiKey = MyApiKey.apiKey;

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

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            backgroundColor: Colors.lightGreen[600],
            content: const Text(
              'Downloaded Successfully',
              style: TextStyle(fontFamily: 'space'),
            ),
          ),
        );
        // Save the image to the gallery
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Download failed',
            style: TextStyle(fontFamily: 'space'),
          ),
        ),
      );
      print('${e.toString()}======');
    }
  }
}
