import 'dart:convert';
import 'package:ecommercial_shopping/core/models/auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommercial_shopping/core/constants/app_config.dart';

class AuthService {
  // static const String _baseUrl = "http://10.0.2.2:8000/api/auth";
  static const String _baseUrl = AppConfig.authEndpoint;

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
        return UserAuth.fromResponseJson(responseData);
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

    final responseBody = response.body;
    print("Signin response: $responseBody");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = jsonDecode(responseBody);

      final userAuth =
          UserAuth.fromResponseJson(responseData); // Parse user + token

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', userAuth.accessToken ?? "");

      return userAuth;
    } else if (response.statusCode == 401) {
      throw Exception("Sai email hoặc mật khẩu");
    } else {
      throw Exception(
          "Đăng nhập thất bại: ${response.statusCode} - $responseBody");
    }
  }
}
