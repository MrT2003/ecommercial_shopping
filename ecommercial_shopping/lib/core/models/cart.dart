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
    return Cart(
      id: json['_id'],
      userId: json['user'],
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
      totalPrice: (json['total_price'] as num).toDouble(),
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

  CartItem({
    required this.productId,
    required this.quantity,
    required this.price,
    required this.name,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['product'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': productId,
      'quantity': quantity,
      'price': price,
      'name': name,
    };
  }
}
