import 'dart:convert';
import 'package:ecommercial_shopping/core/constants/app_config.dart';
import 'package:ecommercial_shopping/core/models/ppl.dart';
import 'package:http/http.dart' as http;

class PplService {
  static const String _baseUrl = AppConfig.pplEndpoint;

  /// Gọi POST /api/ppl/parse với text người dùng nói
  Future<PplParseResult> parseText({
    required String text,
  }) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/parse"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        // Nếu backend bạn dùng key khác (vd "query") thì đổi ở đây
        "text": text,
      }),
    );

    final responseBody = response.body;
    print("PPL Parse response: $responseBody");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data =
          jsonDecode(responseBody) as Map<String, dynamic>;
      return PplParseResult.fromJson(data);
    } else {
      throw Exception(
        "Parse failed: ${response.statusCode} - $responseBody",
      );
    }
  }

  /// Gọi POST /api/ppl/recommend với kết quả parse
  Future<List<PplDrinkRecommendation>> recommend({
    required PplParseResult query,
  }) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/recommend"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(query.toJson()),
    );

    final responseBody = response.body;
    print("PPL Recommend response: $responseBody");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decoded = jsonDecode(responseBody);

      if (decoded is List) {
        return decoded
            .map(
              (e) => PplDrinkRecommendation.fromJson(e as Map<String, dynamic>),
            )
            .toList();
      } else if (decoded is Map<String, dynamic>) {
        // Trường hợp API trả 1 object thay vì array
        return [PplDrinkRecommendation.fromJson(decoded)];
      } else {
        throw Exception("Unexpected recommend response format");
      }
    } else {
      throw Exception(
        "Recommend failed: ${response.statusCode} - $responseBody",
      );
    }
  }
}
