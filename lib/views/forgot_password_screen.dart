import 'package:fitness_app/widgets/custom_button.dart';
import 'package:fitness_app/widgets/custom_text_field.dart';
import 'package:fitness_app/widgets/screen_title.dart';
import 'package:flutter/material.dart';
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height:80,),
              const ScreenTitle(title: "Forget Password"),
              const SizedBox(height: 80),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Email", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
              const SizedBox(height: 8),
              const CustomTextField(hintText: "Enter email"),
              const SizedBox(height: 40),
              CustomButton(text: "Send Code", onPressed: () {},),
            ],
          ),
        ),
      ),
    );
  }
}