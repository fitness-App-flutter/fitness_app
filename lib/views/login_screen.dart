import 'package:flutter/material.dart';
import 'package:test_app/widgets/colors.dart';
import 'package:test_app/widgets/custom_button.dart';
import 'package:test_app/widgets/custom_text_field.dart';
import 'package:test_app/widgets/screen_title.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Screen Title
            const Center(child: ScreenTitle(title: "Welcome Back")),
            const SizedBox(height: 30),

            // Email Field
            const Text("Email", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const CustomTextField(hintText: "Enter your email"),
            const SizedBox(height: 20),

            // Password Field
          const Text("Password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: "Enter your password",
              obscureText: !_isPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),

            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {}, 
                child: const Text("Forgot Password?", style: TextStyle(fontSize: 14, color: MyColors.bluee)),
              ),
            ),
            const SizedBox(height: 20),

            // Login Button
            CustomButton(text: "Login", onPressed: () {}),
            const SizedBox(height: 20),

            // Sign Up Text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?", style: TextStyle(fontSize: 14)),
                TextButton(
                  onPressed: () {},
                  child: const Text("Sign Up", style: TextStyle(fontSize: 14, color: MyColors.bluee)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}