class ArticleModel {
  final String? image;
  final String title;
  final String? subTitle;
  final String? source;
  final DateTime? publishedAt;

  ArticleModel({
    required this.image,
    required this.title,
    required this.subTitle,
    this.source,
    this.publishedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      image: json['urlToImage'],
      title: json['title'] ?? '',
      subTitle: json['author'],
      source: json['source']?['name'],
      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt'].toString())
          : null,
    );
  }

  String get authorName {
    if (subTitle != null && subTitle!.trim().isNotEmpty) {
      return subTitle!.trim();
    }
    if (source != null && source!.trim().isNotEmpty) {
      return source!.trim();
    }
    return 'PharmyGo News';
  }

  String get authorInitial {
    final name = authorName;
    if (name.isEmpty) return 'P';
    return name.substring(0, 1).toUpperCase();
  }
}
