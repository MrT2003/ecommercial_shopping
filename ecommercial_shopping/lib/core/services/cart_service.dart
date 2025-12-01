import 'dart:convert';
import 'package:ecommercial_shopping/core/constants/app_config.dart';
import 'package:ecommercial_shopping/core/models/cart.dart';
import 'package:http/http.dart' as http;

class CartService {
  // static const String _baseUrl = "http://10.0.2.2:8000/api/carts";
  static const String _baseUrl = AppConfig.cartEndpoint;

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
        // Kiểm tra xem response body có rỗng không
        if (response.body.isEmpty) {
          return [];
        }

        List<dynamic> jsonData = json.decode(response.body);

        // Kiểm tra từng item trong jsonData
        List<Cart> carts = [];
        for (var item in jsonData) {
          try {
            Cart cart = Cart.fromJson(item as Map<String, dynamic>);
            carts.add(cart);
          } catch (e) {
            print("Error parsing cart item: $e");
            print("Item data: $item");
            // Bỏ qua item lỗi và tiếp tục
            continue;
          }
        }

        return carts;
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
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/update'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'product_id': productId,
          'quantity': quantity,
        }),
      );

      print("Update response status: ${response.statusCode}");
      print("Update response body: ${response.body}");

      if (response.statusCode != 200) {
        throw Exception(jsonDecode(response.body)['detail'] ?? 'Update failed');
      }
    } catch (e) {
      print("Exception in updateCartItem: $e");
      throw Exception("Error updating cart: $e");
    }
  }

  // Get total price directly from backend
  Future<double> getTotalPrice(String userId) async {
    try {
      final carts = await fetchProductsInCart();

      // Find the cart for the specific user
      final userCart = carts.where((cart) => cart.userId == userId);

      if (userCart.isEmpty) {
        return 0.0;
      }

      // Tính tổng từ tất cả cart của user (nếu có nhiều cart)
      double total = 0.0;
      for (var cart in userCart) {
        total += cart.totalPrice;
      }

      return total;
    } catch (e) {
      print("Error getting total price: $e");
      throw Exception("Error getting total price: $e");
    }
  }
}
