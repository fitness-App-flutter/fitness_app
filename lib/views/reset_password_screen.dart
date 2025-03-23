import 'package:flutter/material.dart';
import 'package:test_app/widgets/custom_button.dart';
import 'package:test_app/widgets/custom_text_field.dart';
import 'package:test_app/widgets/screen_title.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ScreenTitle(title: "Welcome back"),
            const SizedBox(height: 20),

            // New Password Field
            const Align(
                alignment: Alignment.centerLeft,
                child: Text("New Password", style: TextStyle(fontSize: 16))),
            const SizedBox(height: 8),
            const CustomTextField(hintText: "Enter Password", obscureText: true),
            const SizedBox(height: 20),

            // Confirm Password Field
            const Align(
                alignment: Alignment.centerLeft,
                child: Text("Confirm Password", style: TextStyle(fontSize: 16))),
            const SizedBox(height: 8),
            const CustomTextField(hintText: "Confirm Password", obscureText: true),
            const SizedBox(height: 20),

            // Return Login Page Button
            CustomButton(text: "Return Login Page", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}