// password_change_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_projects_1/password_update_screen.dart';
import 'package:flutter_projects_1/widgets/password_related_widgets/changing_password.dart'; // Import the new file

class PasswordChangeScreen extends StatefulWidget {
  const PasswordChangeScreen({super.key});

  @override
  State<PasswordChangeScreen> createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
  bool isPrivate = false;

  void _handleInfoSelected() {
    setState(() {
      isPrivate = false;
    });
  }

  void _handlePrivacySelected() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PasswordUpdateScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildPasswordChangeScreenUI(
      context,
      isPrivate,
      _handleInfoSelected,
      _handlePrivacySelected,
    );
  }
}