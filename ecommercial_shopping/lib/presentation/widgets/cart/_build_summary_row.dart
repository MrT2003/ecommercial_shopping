import 'package:flutter/material.dart';

class _buildSummaryRow extends StatelessWidget {
  final String label;
  final String amount;
  final bool isTotal;
  final Color? labelColor;
  final Color? amountColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const _buildSummaryRow({
    super.key,
    required this.label,
    required this.amount,
    this.isTotal = false,
    this.labelColor,
    this.amountColor,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: labelColor ?? (isTotal ? Colors.black : Colors.grey[600]),
            fontSize: fontSize ?? (isTotal ? 18 : 16),
            fontWeight:
                fontWeight ?? (isTotal ? FontWeight.bold : FontWeight.normal),
          ),
        ),
        Text(
          '\$$amount',
          style: TextStyle(
            color: amountColor ?? (isTotal ? Colors.deepOrange : Colors.black),
            fontSize: fontSize ?? (isTotal ? 20 : 16),
            fontWeight:
                fontWeight ?? (isTotal ? FontWeight.bold : FontWeight.normal),
          ),
        ),
      ],
    );
  }
}
