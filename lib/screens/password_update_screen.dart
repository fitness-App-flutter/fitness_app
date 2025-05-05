import 'package:flutter/material.dart';
import 'package:fitness_app/core/utils/color_extension.dart';
class PasswordUpdateScreen extends StatelessWidget {
  const PasswordUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Password Update"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: MyColors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: const Text("Password Update Screen"),
      ),
    );
  }
}
