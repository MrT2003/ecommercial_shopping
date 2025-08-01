class Cart {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double totalPrice;

  Cart({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalPrice,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    var itemsJson = json['items'] as List? ?? [];
    List<CartItem> itemsList =
        itemsJson.map((item) => CartItem.fromJson(item)).toList();

    // Tính total price nếu backend không có hoặc null
    double calculatedTotal =
        itemsList.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

    return Cart(
      id: json['_id'] ?? '', // Backend dùng _id thay vì id
      userId: json['user'] ?? '', // Backend dùng user thay vì user_id
      items: itemsList,
      totalPrice: json['total_price']?.toDouble() ??
          calculatedTotal, // Fallback nếu backend không có total_price
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'total_price': totalPrice,
    };
  }
}

class CartItem {
  final String productId;
  final int quantity;
  final double price;
  final String name;
  final String image;

  CartItem({
    required this.productId,
    required this.quantity,
    required this.price,
    required this.name,
    required this.image,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId:
          json['product'] ?? '', // Backend dùng product thay vì product_id
      quantity: json['quantity'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': productId,
      'quantity': quantity,
      'price': price,
      'name': name,
      'image': image,
    };
  }
}
