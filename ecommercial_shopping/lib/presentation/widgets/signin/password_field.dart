import 'package:ecommercial_shopping/core/providers/password_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordField extends ConsumerWidget {
  final TextEditingController controller;

  const PasswordField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isObscured = ref.watch(passwordVisibilityProvider);

    return TextField(
      controller: controller,
      style: const TextStyle(height: 2),
      obscureText: isObscured,
      decoration: InputDecoration(
        hintText: 'Password',
        prefixIcon: const Icon(Icons.lock, color: Colors.deepOrange),
        suffixIcon: IconButton(
          icon: Icon(
            isObscured ? Icons.visibility_off : Icons.visibility,
            color: Colors.deepOrange,
          ),
          onPressed: () =>
              ref.read(passwordVisibilityProvider.notifier).toggle(),
        ),
        prefixIconConstraints:
            const BoxConstraints(minWidth: 40, minHeight: 40),
      ),
    );
  }
}
