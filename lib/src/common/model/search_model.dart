class SearchModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String author;
  final double averageRating;

  SearchModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.author,
    required this.averageRating,
  });

  factory SearchModel.fromJson(Map<String, Object?> json) {
    return SearchModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String? ?? '',
      author: json['author'] as String,
      averageRating: json['averageRating'] as double? ?? 0,
    );
  }

  @override
  int get hashCode => Object.hash(
        id,
        title,
        description,
        imageUrl,
        author,
        averageRating,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is SearchModel) {
      return id == other.id &&
          title == other.title &&
          description == other.description &&
          imageUrl == other.imageUrl &&
          author == other.author &&
          averageRating == other.averageRating;
    }

    return false;
  }

  @override
  String toString() {
    return "SearchModel(id: $id, title: $title, description: $description, imageUrl: $imageUrl, author: $author, averageRating: $averageRating)";
  }
}
