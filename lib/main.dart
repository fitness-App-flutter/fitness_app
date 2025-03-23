import 'package:flutter/material.dart';
import 'package:test_app/views/sign_up_screen.dart';
import 'views/health_journey_screen.dart';
import 'views/enter_code_screen.dart';
import 'views/forgot_password_screen.dart';
import 'views/login_screen.dart';
import 'views/reset_password_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:LoginScreen(),
    );
  }
}
