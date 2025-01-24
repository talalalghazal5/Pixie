class PhotoSrc {
  String? original;
  String? large2x;
  String? large;
  String? medium;
  String? small;
  String? portrait;
  String? landscape;
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
