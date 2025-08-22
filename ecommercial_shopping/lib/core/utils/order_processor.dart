import 'package:ecommercial_shopping/core/models/cart.dart';
import 'package:ecommercial_shopping/core/models/order.dart';
import 'package:ecommercial_shopping/core/services/order_service.dart';
import 'package:flutter/material.dart';

class OrderProcessor {
  /// Processes the order, showing a loading dialog and then success or error alert.
  static Future<void> process({
    required BuildContext context,
    required Order order,
    required Cart cart,
    required double totalPrice,
    required String userId,
    required int selectedPaymentMethod,
    required TextEditingController cardNumberController,
    required TextEditingController expiryController,
    required TextEditingController cvvController,
    required TextEditingController cardHolderController,
    required OrderService orderService,
  }) async {
    // Build the Order model
    final newOrder = Order(
      id: '',
      shippingAddress: Address(
        address: order.shippingAddress.address,
        city: order.shippingAddress.city,
        country: order.shippingAddress.country,
      ),
      items: cart.items
          .map((ci) => OrderItem(
                productId: ci.productId,
                quantity: ci.quantity,
                price: ci.price,
              ))
          .toList(),
      paymentMethod: selectedPaymentMethod == 0 ? 'Credit Card' : 'COD',
      paymentStatus: 'pending',
      totalPrice: totalPrice,
      userId: userId,
    );

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Processing your order...'),
          ],
        ),
      ),
    );

    // Call API
    bool success = false;
    try {
      success = await orderService.placeOrder(newOrder);
    } catch (e) {
      success = false;
    } finally {
      Navigator.pop(context); // Close loading
    }

    // Show result
    if (success) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text('Order Successful!'),
            ],
          ),
          content: const Text(
            'Your order has been placed successfully. You will receive a confirmation email shortly.',
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close success dialog
                Navigator.pop(context); // Back to previous
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
              ),
              child: const Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed to place order. Please try again.')),
      );
    }
  }
}
