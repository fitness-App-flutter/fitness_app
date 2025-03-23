import 'package:flutter/material.dart';
import 'package:test_app/views/health_journey_screen%20copy.dart';
import 'package:test_app/views/enter_code_screen%20copy.dart';
import 'package:test_app/views/forgot_password_screen%20copy.dart';
import 'package:test_app/views/login_screen%20copy.dart';
import 'package:test_app/views/reset_password_screen%20copy.dart';
import 'package:test_app/views/sign_up_screen%20copy.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HealthJourneyScreen(),
    );
  }
}
