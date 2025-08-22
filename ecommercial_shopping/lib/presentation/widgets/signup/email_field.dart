import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;

  const EmailField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(height: 2.0),
      decoration: const InputDecoration(
        hintText: 'Email',
        prefixIcon: Icon(
          Icons.email,
          color: Colors.deepOrange,
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 40, minHeight: 40),
      ),
    );
  }
}
