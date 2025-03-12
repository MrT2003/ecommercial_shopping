import 'package:ecommercial_shopping/presentation/pages/home_screen.dart';
import 'package:ecommercial_shopping/presentation/pages/signin_screen.dart';
import 'package:ecommercial_shopping/presentation/pages/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommercial Shopping',
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/signin',
      routes: {
        '/signup': (context) => SignupScreen(),
        '/signin': (context) => SigninScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
