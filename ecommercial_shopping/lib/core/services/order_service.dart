import 'dart:convert';
import 'package:http/http.dart' as http;

class CartService {
  static const String _baseUrl = "http://10.0.2.2:8000/api/orders";

  Future<bool> addToCart({
    required String userId,
    required String productId,
    required int quantity,
    required double price,
    required String name,
    required String image,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/add"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "user_id": userId,
          "product_id": productId,
          "quantity": quantity,
          "price": price,
          "name": name,
          "image": image,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Error: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }
}
