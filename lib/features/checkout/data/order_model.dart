class OrderModel {
  final int id;
  final String totalPrice;
  final String status;
  final String date;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.totalPrice,
    required this.status,
    required this.date,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? 0,
      totalPrice: json['total_price']?.toString() ?? '0.00',
      status: json['status'] ?? 'Pending',
      date: json['created_at'] ?? '', // API usually returns created_at
      items: (json['items'] as List?)
              ?.map((e) => OrderItemModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class OrderItemModel {
  final int itemId;
  final String name;
  final String image;
  final int quantity;
  final String price;

  OrderItemModel({
    required this.itemId,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      itemId: json['item_id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      image: json['image'] ?? '',
      quantity: int.tryParse(json['quantity']?.toString() ?? '1') ?? 1,
      price: json['price']?.toString() ?? '0.00',
    );
  }
}
