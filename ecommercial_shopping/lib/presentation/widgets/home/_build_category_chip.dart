import 'package:flutter/material.dart';

class _buildCategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function()? onTap;

  const _buildCategoryChip({
    Key? key,
    required this.label,
    required this.isSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Chip(
          backgroundColor: isSelected ? Colors.deepOrange : Colors.white,
          label: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
