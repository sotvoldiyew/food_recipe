class CategoryModel {
  final int id;
  final String name;

  CategoryModel({
    required this.id,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, Object?> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  @override
  int get hashCode => Object.hash(id, name);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is CategoryModel) {
      return id == other.id && name == other.name;
    }

    return false;
  }

  @override
  String toString() {
    return "CategoryModel(id: $id, name: $name)";
  }
}
