import 'dart:convert';
import 'package:ecommercial_shopping/core/models/order.dart';
import 'package:http/http.dart' as http;

class OrderService {
  static const String _baseUrl = "http://10.0.2.2:8000/api/orders";

  Future<bool> placeOrder(Order order) async {
    final url = Uri.parse("$_baseUrl"); // hoặc "$_baseUrl/place" tuỳ backend
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "items": order.items
            .map((item) => {
                  "product": item.productId,
                  "quantity": item.quantity,
                  "price": item.price,
                })
            .toList(),
        "payment_method": order.paymentMethod,
        "payment_status": order.paymentStatus,
        "shipping_address": order.shippingAddress.toJson(),
        "total_price": order.totalPrice,
        "user_id": order.userId,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print("Failed to place order: ${response.statusCode} ${response.body}");
      return false;
    }
  }
}
