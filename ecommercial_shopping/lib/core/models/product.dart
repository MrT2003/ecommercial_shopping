class Product {
  final String id;
  final String name;
  final String description;
  final double rates;
  final double price;
  final double distance;
  final int calories;
  final String preparationTime;
  final List<String> tags;
  final String imageUrl;
  final List<String> category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.rates,
    required this.price,
    required this.distance,
    required this.calories,
    required this.preparationTime,
    required this.tags,
    required this.imageUrl,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      rates: (json['rates'] as num?)?.toDouble() ?? 0.0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
      calories: json['calories'] ?? 0,
      preparationTime: json['preparationTime'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      imageUrl: json['imageURL'] ?? '',
      category: List<String>.from(json['category'] ?? []),
    );
  }
}
