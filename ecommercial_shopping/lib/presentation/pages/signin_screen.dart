import 'package:ecommercial_shopping/core/providers/auth_provider.dart';
import 'package:ecommercial_shopping/presentation/widgets/signin/email_field.dart';
import 'package:ecommercial_shopping/presentation/widgets/signin/password_field.dart';
import 'package:ecommercial_shopping/presentation/widgets/signin/signin_button.dart';
import 'package:ecommercial_shopping/presentation/widgets/signin/signin_text.dart';
import 'package:ecommercial_shopping/presentation/widgets/signin/signup_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SigninScreen extends ConsumerWidget {
  SigninScreen({super.key});
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SignInText(),
              const SizedBox(height: 50),
              EmailField(controller: _emailCon),
              const SizedBox(height: 20),
              PasswordField(controller: _passwordCon),
              const SizedBox(height: 80),
              SignInButton(
                emailController: _emailCon,
                passwordController: _passwordCon,
              ),
              const SizedBox(height: 20),
              const SignUpText(),
            ],
          ),
        ),
      ),
    );
  }
}
