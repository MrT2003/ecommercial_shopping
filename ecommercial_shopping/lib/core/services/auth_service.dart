import 'dart:convert';
import 'package:ecommercial_shopping/core/models/auth.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = "http://10.0.2.2:8000/api/auth";

  Future<UserAuth> signup({
    required String name,
    required String email,
    required String password,
    String? phone,
    String? address,
  }) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "address": address,
      }),
    );

    final responseBody = response.body;
    print("Signup response: $responseBody");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = jsonDecode(responseBody);

      if (responseData.containsKey('_id')) {
        return UserAuth.fromJson(responseData);
      } else {
        throw Exception("Signup failed: Missing '_id' in response");
      }
    } else {
      throw Exception("Signup failed: ${response.statusCode} - $responseBody");
    }
  }

  Future<UserAuth> signin({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return UserAuth.fromJson(responseData);
    } else {
      throw Exception(
          "Signin failed: ${response.statusCode} - ${response.body}");
    }
  }
}
