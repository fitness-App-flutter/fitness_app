// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'password_update_screen.dart';
import 'health_screen.dart';
import 'add_meal_screen.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ProfileScreen(), // Set ProfileScreen as the starting screen
    );
  }
}