import 'package:fitness_app/widgets/custom_button.dart';
import 'package:fitness_app/widgets/custom_text_field.dart';
import 'package:fitness_app/widgets/screen_title.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Screen Title
              const SizedBox(height: 40),
              const Center(child: ScreenTitle(title: "Welcome Back")),
              const SizedBox(height: 80),

              // Email Field
              const Text("Email",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const CustomTextField(hintText: "Enter your email"),
              const SizedBox(height: 20),

              // Password Field
              const Text("Password",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const CustomTextField(
                  hintText: "Enter your password", obscureText: true),
              const SizedBox(height: 10),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Forgot Password?",
                      style: TextStyle(fontSize: 14, color: Color(0xff626ae7))),
                ),
              ),
              const SizedBox(height: 20),

              // Login Button
              CustomButton(
                text: "Login",
                onPressed: () {},
                backgroundColor: const Color(0xff626ae7),
              ),
              const SizedBox(height: 120),

              // Sign Up Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?",
                      style: TextStyle(fontSize: 14)),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Sign Up",
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff626ae7))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
