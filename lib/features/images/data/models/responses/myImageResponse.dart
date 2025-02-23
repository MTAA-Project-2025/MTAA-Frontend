class MyImageResponse {
  final String id;
  final String shortPath;
  final String fullPath;
  final String fileType;
  final int height;
  final int width;
  final double aspectRatio;

  MyImageResponse({
    required this.id,
    required this.shortPath,
    required this.fullPath,
    required this.fileType,
    required this.height,
    required this.width,
    required this.aspectRatio,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shortPath': shortPath,
      'fullPath': fullPath,
      'fileType': fileType,
      'height': height,
      'width': width,
      'aspectRatio': aspectRatio,
    };
  }

  factory MyImageResponse.fromJson(Map<String, dynamic> json) {
    return MyImageResponse(
      id: json['id'],
      shortPath: json['shortPath'],
      fullPath: json['fullPath'],
      fileType: json['fileType'],
      height: json['height'],
      width: json['width'],
      aspectRatio:(json['aspectRatio'] as num).toDouble(),
    );
  }
}