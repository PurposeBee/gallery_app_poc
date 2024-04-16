class HitImage {
  int id;
  int likes;
  int views;
  double height;
  double width;
  List<String> tags;
  String type;
  String pageUrl;
  String largeImageUrl;

  HitImage(
      {required this.id,
      required this.likes,
      required this.views,
      required this.height,
      required this.width,
      required this.tags,
      required this.type,
      required this.pageUrl,
      required this.largeImageUrl});

  static HitImage fromJson(json) {
    return HitImage(
        id: json['id'],
        likes: json['likes'],
        views: json['views'],
        height: (json['imageHeight'] as int).toDouble(),
        width: (json['imageWidth'] as int).toDouble(),
        tags: (json['tags'] as String).split(',').map((e) => e.trim()).toList(),
        type: (json['type'] as String),
        pageUrl: json['pageURL'],
        largeImageUrl: json['largeImageURL']);
  }
}
