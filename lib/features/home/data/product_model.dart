class ProductModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final String rating;
  final double price;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.rating,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      rating: (json['rating'] ?? '0.0').toString(),
      price: double.tryParse(json['price'].toString()) ?? 0.0,
    );
  }
}
