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
  final String categoryId;

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
    required this.categoryId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      rates: (json['rates'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      distance: (json['distance'] as num).toDouble(),
      calories: json['calories'],
      preparationTime: json['preparationTime'],
      tags: List<String>.from(json['tags']),
      imageUrl: json['imageURL'],
      categoryId: json['category_id'],
    );
  }
}
