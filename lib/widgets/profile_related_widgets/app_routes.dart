// app_routes.dart
import 'package:flutter/material.dart';
import 'package:fitness_app/auth/views/login_screen.dart';
import 'package:fitness_app/screens/overview_page.dart';
import 'package:fitness_app/screens/profile_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const OverviewPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined')),
          ),
        );
    }
  }
}
