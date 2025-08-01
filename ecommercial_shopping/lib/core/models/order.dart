class Order {
  final String id;
  final Address shippingAddress;
  final List<OrderItem> items;
  final String paymentMethod;
  final String paymentStatus;
  final double totalPrice;
  final String userId;

  Order({
    required this.id,
    required this.shippingAddress,
    required this.items,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.totalPrice,
    required this.userId,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var itemsJson = json['items'] as List? ?? [];
    List<OrderItem> itemsList =
        itemsJson.map((item) => OrderItem.fromJson(item)).toList();

    return Order(
      id: json['_id'] ?? '',
      shippingAddress: Address.fromJson(json['shipping_address'] ?? {}),
      items: itemsList,
      paymentMethod: json['payment_method'] ?? '',
      paymentStatus: json['payment_status'] ?? '',
      totalPrice: (json['total_price'] ?? 0).toDouble(),
      userId: json['user_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'shipping_address': shippingAddress.toJson(),
      'items': items.map((item) => item.toJson()).toList(),
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'total_price': totalPrice,
      'user_id': userId,
    };
  }
}

class Address {
  final String address;
  final String city;
  final String country;

  Address({
    required this.address,
    required this.city,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'city': city,
      'country': country,
    };
  }
}

class OrderItem {
  final String productId;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['product'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': productId,
      'quantity': quantity,
      'price': price,
    };
  }
}
