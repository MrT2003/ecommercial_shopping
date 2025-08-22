import 'package:flutter/material.dart';

class UserNameField extends StatelessWidget {
  final TextEditingController controller;

  const UserNameField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(height: 2.0),
      decoration: const InputDecoration(
        hintText: 'Username',
        prefixIcon: Icon(
          Icons.person,
          color: Colors.deepOrange,
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 40, minHeight: 40),
      ),
    );
  }
}
