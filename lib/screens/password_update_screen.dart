import 'package:flutter/material.dart';

class PasswordUpdateScreen extends StatelessWidget {
  const PasswordUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Password Update"),
        leading: const Icon(Icons.arrow_back_ios),
      ),
      body: Center(
        child: const Text("Password Update Screen"),
      ),
    );
  }
}
