import 'package:flutter/material.dart';

class BuildPaymentOption extends StatelessWidget {
  final int index;
  final String title;
  final IconData icon;
  final int selectedPaymentMethod;
  final Function(int) onPaymentMethodChanged;

  const BuildPaymentOption({
    super.key,
    required this.index,
    required this.title,
    required this.icon,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedPaymentMethod == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onPaymentMethodChanged(index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.deepOrange : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.deepOrange : Colors.grey.shade300,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey[600],
              ),
              SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[600],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
