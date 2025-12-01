import 'dart:convert';
import 'package:ecommercial_shopping/core/constants/app_config.dart';
import 'package:ecommercial_shopping/core/models/ppl.dart';
import 'package:http/http.dart' as http;

class PplService {
  static const String _baseUrl = AppConfig.pplEndpoint;

  String _extractErrorMessage(int statusCode, String responseBody) {
    try {
      final decoded = jsonDecode(responseBody);

      if (decoded is Map<String, dynamic>) {
        final detail = decoded['detail'];

        if (detail is String) {
          return detail;
        }

        if (detail is Map<String, dynamic>) {
          if (detail['message'] is String) {
            return detail['message'] as String;
          }
        }

        if (detail is List && detail.isNotEmpty) {
          final first = detail.first;
          if (first is Map<String, dynamic> && first['msg'] is String) {
            return first['msg'] as String;
          }
        }
      }

      return 'Lỗi ($statusCode): $responseBody';
    } catch (_) {
      return 'Lỗi ($statusCode): $responseBody';
    }
  }

  /// Gọi POST /api/ppl/parse với text người dùng nói
  Future<PplParseResult> parseText({
    required String text,
  }) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/parse"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "text": text,
      }),
    );

    // 🔥 TỰ decode UTF-8, bỏ qua charset trong header
    final responseBody = utf8.decode(response.bodyBytes);
    print("PPL Parse response: $responseBody");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data =
          jsonDecode(responseBody) as Map<String, dynamic>;
      return PplParseResult.fromJson(data);
    } else {
      final msg = _extractErrorMessage(response.statusCode, responseBody);
      throw Exception(msg);
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

    // 🔥 Tương tự, decode bodyBytes
    final responseBody = utf8.decode(response.bodyBytes);
    print("PPL Recommend response: $responseBody");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final decoded = jsonDecode(responseBody);

      if (decoded is List) {
        return decoded
            .map(
              (e) => PplDrinkRecommendation.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList();
      } else if (decoded is Map<String, dynamic>) {
        return [PplDrinkRecommendation.fromJson(decoded)];
      } else {
        throw Exception("Unexpected recommend response format");
      }
    } else {
      final msg = _extractErrorMessage(response.statusCode, responseBody);
      throw Exception(msg);
    }
  }
}
