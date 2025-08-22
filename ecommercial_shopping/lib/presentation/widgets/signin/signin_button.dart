import 'package:ecommercial_shopping/core/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInButton extends ConsumerWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const SignInButton({
    Key? key,
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
              final email = emailController.text.trim();
              final pass = passwordController.text.trim();

              if (email.isEmpty || pass.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Vui lòng nhập đầy đủ email và mật khẩu'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }

              try {
                await ref.read(authStateProvider.notifier).signin(
                      email: email,
                      password: pass,
                    );

                final authUser = ref.read(authStateProvider).value;
                if (authUser != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sign in successful'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pushReplacementNamed(context, '/home');
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Đăng nhập thất bại'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Đăng nhập thất bại: $e'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
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
              'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
