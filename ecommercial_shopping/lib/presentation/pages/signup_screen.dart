import 'package:ecommercial_shopping/core/models/auth.dart';
import 'package:ecommercial_shopping/core/providers/auth_provider.dart';
import 'package:ecommercial_shopping/core/providers/password_provider.dart';
import 'package:ecommercial_shopping/presentation/pages/signin_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupScreen extends ConsumerWidget {
  SignupScreen({super.key});
  final TextEditingController _usernameCon = TextEditingController();
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
              _signup(),
              const SizedBox(height: 50),
              _userNameField(),
              const SizedBox(height: 20),
              _emailField(),
              const SizedBox(height: 20),
              _passwordField(context, ref),
              const SizedBox(height: 60),
              _createAccountButton(context, ref),
              const SizedBox(height: 20),
              _signinText(context)
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
          color: Color(0xff2A4ECA), fontWeight: FontWeight.bold, fontSize: 32),
    );
  }

  Widget _userNameField() {
    return TextField(
      controller: _usernameCon,
      style: const TextStyle(height: 2.0),
      decoration: const InputDecoration(
        hintText: 'Username',
        prefixIcon: Icon(Icons.person),
        prefixIconConstraints: BoxConstraints(minWidth: 40, minHeight: 40),
      ),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _emailCon,
      style: const TextStyle(height: 2.0),
      decoration: const InputDecoration(
        hintText: 'Email',
        prefixIcon: Icon(Icons.email),
        prefixIconConstraints: BoxConstraints(minWidth: 40, minHeight: 40),
      ),
    );
  }

  Widget _passwordField(BuildContext context, WidgetRef ref) {
    final isObscured = ref.watch(passwordVisibilityProvider);

    return TextField(
      controller: _passwordCon,
      style: const TextStyle(height: 2),
      obscureText: isObscured,
      decoration: InputDecoration(
        hintText: 'Password',
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(isObscured ? Icons.visibility_off : Icons.visibility),
          onPressed: () =>
              ref.read(passwordVisibilityProvider.notifier).toggle(),
        ),
        prefixIconConstraints:
            const BoxConstraints(minWidth: 40, minHeight: 40),
      ),
    );
  }

  Widget _createAccountButton(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return ElevatedButton(
      onPressed: authState is AsyncLoading
          ? null // Disable button khi loading
          : () async {
              if (_usernameCon.text.isEmpty ||
                  _emailCon.text.isEmpty ||
                  _passwordCon.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill all fields'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }

              await ref.read(authStateProvider.notifier).signup(
                    name: _usernameCon.text,
                    email: _emailCon.text,
                    password: _passwordCon.text,
                  );

              final newState = ref.watch(authStateProvider);
              newState.when(
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
                loading: () => {},
                error: (err, stack) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Signup failed: $err'),
                      duration: const Duration(seconds: 20),
                    ),
                  );
                },
              );
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff3461FD),
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

  Widget _signinText(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        const TextSpan(
            text: 'Do you have an account?',
            style: TextStyle(
                color: Color(0xff3B4054), fontWeight: FontWeight.w500)),
        TextSpan(
            text: ' Sign In',
            style: const TextStyle(
                color: Color(0xff3461FD), fontWeight: FontWeight.w500),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SigninScreen(),
                    ));
              })
      ]),
    );
  }
}
