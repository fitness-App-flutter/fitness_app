import 'package:flutter/material.dart';
import 'package:test_app/widgets/custom_button.dart';
import 'package:test_app/widgets/custom_text_field.dart';
import 'package:test_app/widgets/screen_title.dart';


class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ScreenTitle(title: "Forget Password"),
            const SizedBox(height: 20),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text("Email", style: TextStyle(fontSize: 16))),
            const SizedBox(height: 8),
            const CustomTextField(hintText: "Enter email"),
            const SizedBox(height: 20),
            CustomButton(text: "Send Code", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}