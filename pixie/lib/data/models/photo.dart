import 'package:hive/hive.dart';
import 'package:pixie/data/models/photo_src.dart';
part 'photo.g.dart';

@HiveType(typeId: 0)
class Photo {
  @HiveField(0)
  int id;
  
  @HiveField(1)
  int width;
  
  @HiveField(2)
  int height;
  
  @HiveField(3)
  String url;
  
  @HiveField(4)
  String photographer;
  
  @HiveField(5)
  String? photographerUrl;
  
  @HiveField(6)
  int? photographerId;
  
  @HiveField(7)
  String avgColor;
  
  @HiveField(8)
  PhotoSrc src;
  
  @HiveField(9)
  bool? liked;
  
  @HiveField(10)
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
