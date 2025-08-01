import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;

  const BuildTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required TextEditingController controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(icon, color: Colors.deepOrange),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              )),
        ),
      ],
    );
  }
}
