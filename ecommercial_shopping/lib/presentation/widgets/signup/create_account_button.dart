import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommercial_shopping/core/providers/auth_provider.dart';

class CreateAccountButton extends ConsumerWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const CreateAccountButton({
    Key? key,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return ElevatedButton(
      onPressed: authState is AsyncLoading
          ? null
          : () async {
              final username = usernameController.text.trim();
              final email = emailController.text.trim();
              final password = passwordController.text.trim();

              if (username.isEmpty || email.isEmpty || password.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill all fields'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }

              // Call signup on provider
              await ref.read(authStateProvider.notifier).signup(
                    name: username,
                    email: email,
                    password: password,
                  );

              // Read new state and show feedback
              ref.watch(authStateProvider).when(
                    data: (user) {
                      if (user != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Signup successful! Redirecting...'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.pushReplacementNamed(context, '/home');
                        });
                      }
                    },
                    loading: () {},
                    error: (err, _) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Signup failed: \$err'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  );
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: authState is AsyncLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text(
              'Create Account',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
