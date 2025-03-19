import 'package:pixie/data/models/photo_src.dart';

class Photo {
  int id;
  int width;
  int height;
  String url;
  String photographer;
  String? photographerUrl;
  int? photographerId;
  String avgColor;
  PhotoSrc src;
  bool? liked;
  String? alt;

  Photo(
      {required this.id,
      required this.width,
      required this.height,
      required this.url,
      required this.photographer,
      required this.photographerId,
      required this.photographerUrl,
      required this.avgColor,
      required this.src,
      this.liked = false,
      this.alt});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      width: json['width'],
      height: json['height'],
      url: json['url'],
      photographer: json['photographer'],
      photographerId: json['photographer_id'] ?? 0,
      photographerUrl: json['photographer_url'] ?? '',
      avgColor: json['avg_color'],
      src: PhotoSrc.fromJson(json['src']),
      alt: json['alt'],
      liked: json['liked'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'width' : width,
      'height': height,
      'url': url,
      'photographer': photographer,
      'photographer_id': photographerId,
      'photographer_url': photographerUrl,
      'avg_color': avgColor,
      'src': src.toJson(),
      'alt': alt,
      'liked': liked,
    };
  }
  
}
