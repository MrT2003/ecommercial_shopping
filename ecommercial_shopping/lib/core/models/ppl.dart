class PplParseResult {
  final String? temperature;
  final String? baseType;
  final String? sweetness;
  final String? caffeine;
  final String? size;

  const PplParseResult({
    this.temperature,
    this.baseType,
    this.sweetness,
    this.caffeine,
    this.size,
  });

  factory PplParseResult.fromJson(Map<String, dynamic> json) {
    String? normalize(dynamic v) {
      if (v == null) return null;
      if (v is String && v.toLowerCase() == 'null') return null;
      return v.toString();
    }

    return PplParseResult(
      temperature: normalize(json['temperature']),
      baseType: normalize(json['baseType']),
      sweetness: normalize(json['sweetness']),
      caffeine: normalize(json['caffeine']),
      size: normalize(json['size']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'baseType': baseType,
      'sweetness': sweetness,
      'caffeine': caffeine,
      'size': size,
    };
  }
}

class PplDrinkRecommendation {
  final String id;
  final String name;
  final String description;
  final String category;
  final String drinkCategory;
  final List<String> temperatures;
  final String? sweetnessLevel;
  final double price;
  final String? imageURL;

  const PplDrinkRecommendation({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.drinkCategory,
    required this.temperatures,
    this.sweetnessLevel,
    required this.price,
    this.imageURL,
  });

  factory PplDrinkRecommendation.fromJson(Map<String, dynamic> json) {
    return PplDrinkRecommendation(
      id: (json['id'] ?? json['_id'] ?? '') as String,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      drinkCategory: json['drinkCategory'] as String? ?? '',
      temperatures: (json['temperatures'] as List<dynamic>? ?? const [])
          .map((e) => e.toString())
          .toList(),
      sweetnessLevel: json['sweetnessLevel'] as String?,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      imageURL: json['imageURL'] as String?,
    );
  }
}
