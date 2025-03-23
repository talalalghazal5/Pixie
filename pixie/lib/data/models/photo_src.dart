import 'package:hive/hive.dart';

part 'photo_src.g.dart';

@HiveType(typeId: 1)
class PhotoSrc {
  @HiveField(0)
  String? original;

  @HiveField(1)
  String? large2x;
  
  @HiveField(2)
  String? large;
  
  @HiveField(3)
  String? medium;
  
  @HiveField(4)
  String? small;
  
  @HiveField(5)
  String? portrait;
  
  @HiveField(6)
  String? landscape;
  
  @HiveField(7)
  String? tiny;

  PhotoSrc(
    this.original,
    this.large2x,
    this.large,
    this.medium,
    this.small,
    this.portrait,
    this.landscape,
    this.tiny,
  );

  factory PhotoSrc.fromJson(Map<String, dynamic> json) {
    return PhotoSrc(
      json['original'],
      json['large2x'],
      json['large'],
      json['medium'],
      json['small'],
      json['portrait'],
      json['landscape'],
      json['tiny'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'original' : original,
      'large2x' : large2x,
      'large' : large,
      'medium' : medium,
      'small' : small,
      'portrait' : portrait,
      'landscape' : landscape,
      'tiny' : tiny,
    };
  }
}
