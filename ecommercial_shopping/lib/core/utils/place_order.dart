import 'package:flutter/material.dart';
import 'package:ecommercial_shopping/core/models/cart.dart';

class PlaceOrder {
  static void show({
    required BuildContext context,
    required Cart cart,
    required double totalPrice,
    required int selectedPaymentMethod,
    required TextEditingController cardNumberController,
    required TextEditingController expiryController,
    required TextEditingController cvvController,
    required TextEditingController cardHolderController,
    required VoidCallback onProcessOrder,
  }) {
    if (selectedPaymentMethod == 0) {
      if (cardNumberController.text.isEmpty ||
          expiryController.text.isEmpty ||
          cvvController.text.isEmpty ||
          cardHolderController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all card details')),
        );
        return;
      }
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Order'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Amount: \$${totalPrice.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            Text(
              'Payment Method: ${selectedPaymentMethod == 0 ? "Credit Card" : "Cash on Delivery"}',
            ),
            const SizedBox(height: 8),
            Text('Items: ${cart.items.length}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onProcessOrder();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
            ),
            child: const Text('Confirm', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
