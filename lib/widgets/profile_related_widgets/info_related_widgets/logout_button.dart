import 'package:fitness_app/core/utils/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  void _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to login screen after logout
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _logout(context),
      icon: const Icon(
        Icons.logout,
        color: Colors.white, // Change this to any color you like
      ),

      label: const Text('Logout'),
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.PrimaryBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
