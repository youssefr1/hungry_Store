

class CartModel {
  final int itemId;
  final int productId;
  final String name;
  final String image;
  final int quantity;
  final double price;
  final double spicy;
  final List<dynamic> toppings;
  final List<dynamic> sideOptions;

  CartModel({
    required this.itemId,
    required this.productId,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
    required this.spicy,
    required this.toppings,
    required this.sideOptions,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      itemId: json['item_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      image: json['image'] ?? '',
      quantity: int.tryParse(json['quantity']?.toString() ?? '1') ?? 1,
      price: double.tryParse(json['price']?.toString() ?? '0.0') ?? 0.0,
      spicy: double.tryParse(json['spicy']?.toString() ?? '0.0') ?? 0.0,
      toppings: json['toppings'] ?? [],
      sideOptions: json['side_options'] ?? [],
    );
  }

  double get totalPrice => price * quantity;
}
