import 'dart:convert';
import 'package:ecommercial_shopping/core/models/category.dart';
import 'package:ecommercial_shopping/core/models/product.dart';
import 'package:ecommercial_shopping/core/constants/app_config.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // static const String baseUrl = "http://10.0.2.2:8000/api";
  static const String baseUrl = AppConfig.baseUrl;

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products/'));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<Product>> fetchProductsByName(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/search?query=$query'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;
        return jsonData.map((json) => Product.fromJson(json)).toList();
      } else {
        // ❗ Với search: coi như không tìm thấy sản phẩm → trả [] thay vì throw
        print(
            "Search failed ${response.statusCode}: ${response.body}"); // log để debug
        return [];
      }
    } catch (e) {
      // ❗ Lỗi mạng/bất ngờ → cũng trả [] cho user, không quăng exception ra UI
      print("Search exception: $e");
      return [];
    }
  }

  Future<List<Category>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/categories/'));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<List<Category>> fetchCarts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/carts/'));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load carts");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
