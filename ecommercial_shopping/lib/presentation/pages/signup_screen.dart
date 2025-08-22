import 'package:ecommercial_shopping/presentation/widgets/signin/password_field.dart';
import 'package:ecommercial_shopping/presentation/widgets/signin/signup_text.dart';
import 'package:ecommercial_shopping/presentation/widgets/signup/create_account_button.dart';
import 'package:ecommercial_shopping/presentation/widgets/signup/email_field.dart';
import 'package:ecommercial_shopping/presentation/widgets/signup/signin_text.dart';
import 'package:ecommercial_shopping/presentation/widgets/signup/username_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupScreen extends ConsumerWidget {
  SignupScreen({super.key});
  final TextEditingController _usernameCon = TextEditingController();
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final authState = ref.watch(authStateProvider);
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SignUpText(),
              const SizedBox(height: 50),
              UserNameField(
                controller: _usernameCon,
              ),
              const SizedBox(height: 20),
              EmailField(
                controller: _emailCon,
              ),
              const SizedBox(height: 20),
              PasswordField(
                controller: _passwordCon,
              ),
              const SizedBox(height: 60),
              CreateAccountButton(
                usernameController: _usernameCon,
                emailController: _emailCon,
                passwordController: _passwordCon,
              ),
              const SizedBox(height: 20),
              const SigninText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signup() {
    return const Text(
      'Sign Up',
      style: TextStyle(
          color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 32),
    );
  }

  Widget _userNameField() {
    return TextField(
      controller: _usernameCon,
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
