import 'package:fitness_app/widges/custom_button.dart';
import 'package:fitness_app/widges/custom_text_field.dart';
import 'package:fitness_app/widges/screen_title.dart';
import 'package:flutter/material.dart';
class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height:80,),
              const ScreenTitle(title: "Welcome back"),
              const SizedBox(height: 90),
          
              // New Password Field
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("New Password", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
              const SizedBox(height: 5),
              const CustomTextField(hintText: "Enter Password", obscureText: true),
              const SizedBox(height: 10),
          
              // Confirm Password Field
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Confirm Password", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
              const SizedBox(height: 5),
              const CustomTextField(hintText: "Confirm Password", obscureText: true),
              const SizedBox(height: 60),
          
              // Return Login Page Button
              CustomButton(text: "Return Login Page", onPressed: () {},),
            ],
          ),
        ),
      ),
    );
  }
}