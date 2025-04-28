import 'dart:convert';
import 'package:ecommercial_shopping/core/models/cart.dart';
import 'package:http/http.dart' as http;

class CartService {
  static const String _baseUrl = "http://10.0.2.2:8000/api/carts";

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

  Future<List<Cart>> fetchProductsInCart() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/'));
      print("Status code: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Cart.fromJson(json)).toList();
      } else {
        throw Exception(
            "Failed to load products: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Exception in fetchProductsInCart: $e");
      throw Exception("Error: $e");
    }
  }

  Future<void> updateCartItem({
    required String userId,
    required String productId,
    required int quantity,
  }) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/update'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'product_id': productId,
        'quantity': quantity,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)['detail']);
    }
  }
}
