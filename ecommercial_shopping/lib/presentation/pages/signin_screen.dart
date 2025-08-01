import 'package:ecommercial_shopping/core/models/auth.dart';
import 'package:ecommercial_shopping/core/providers/auth_provider.dart';
import 'package:ecommercial_shopping/core/providers/password_provider.dart';
import 'package:ecommercial_shopping/presentation/pages/signin_screen.dart';
import 'package:ecommercial_shopping/presentation/pages/signup_screen.dart';
import 'package:flutter/gestures.dart';
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
              _signin(),
              const SizedBox(height: 50),
              _emailField(),
              const SizedBox(height: 20),
              _passwordField(context, ref),
              const SizedBox(height: 80),
              _signinButton(context, ref, authState),
              const SizedBox(height: 20),
              _signupText(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _signin() {
    return const Text(
      'Sign In',
      style: TextStyle(
          color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 32),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _emailCon,
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

  Widget _passwordField(BuildContext context, WidgetRef ref) {
    final isObscured = ref.watch(passwordVisibilityProvider);

    return TextField(
      controller: _passwordCon,
      style: const TextStyle(height: 2),
      obscureText: isObscured,
      decoration: InputDecoration(
        hintText: 'Password',
        prefixIcon: const Icon(
          Icons.lock,
          color: Colors.deepOrange,
        ),
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

  Widget _signinButton(
      BuildContext context, WidgetRef ref, AsyncValue<UserAuth?> authState) {
    return ElevatedButton(
      onPressed: authState is AsyncLoading
          ? null
          : () async {
              if (_emailCon.text.isNotEmpty && _passwordCon.text.isNotEmpty) {
                try {
                  await ref.read(authStateProvider.notifier).signin(
                        email: _emailCon.text,
                        password: _passwordCon.text,
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
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Vui lòng nhập đầy đủ email và mật khẩu'),
                    duration: Duration(seconds: 2),
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
      child: const Text(
        'Sign In',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _signupText(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        const TextSpan(
            text: 'Don\'t have account?',
            style: TextStyle(
                color: Color(0xff3B4054), fontWeight: FontWeight.w500)),
        TextSpan(
            text: ' Sign Up',
            style: const TextStyle(
                color: Colors.deepOrange, fontWeight: FontWeight.w500),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupScreen(),
                    ));
              })
      ]),
    );
  }
}
