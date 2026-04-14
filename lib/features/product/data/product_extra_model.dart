class ExtraOption {
  final int id;
  final String name;
  final String image;

  ExtraOption({
    required this.id,
    required this.name,
    required this.image,
  });

  factory ExtraOption.fromJson(Map<String, dynamic> json) {
    return ExtraOption(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}

class CategoryModel {
  final int id;
  final String name;

  CategoryModel({
    required this.id,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
