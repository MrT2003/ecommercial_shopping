import 'package:flutter/material.dart';

class SignUpText extends StatelessWidget {
  const SignUpText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Sign Up',
      style: TextStyle(
        color: Colors.deepOrange,
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
    );
  }
}
