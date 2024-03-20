class News {
  final NewsSource source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  News({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      source: NewsSource.fromJson(json['source']),
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: DateTime.tryParse(json['publishedAt']) ?? DateTime.now(),
      content: json['content'] ?? '',
    );
  }
}

class NewsSource {
  final String id;
  final String name;

  NewsSource({
    required this.id,
    required this.name,
  });

  factory NewsSource.fromJson(Map<String, dynamic> json) {
    return NewsSource(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}