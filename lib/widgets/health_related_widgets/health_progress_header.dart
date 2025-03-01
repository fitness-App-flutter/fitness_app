import 'package:flutter/material.dart';
import 'package:flutter_projects_1/color_extension.dart';

class HealthProgressHeader extends StatelessWidget {
  final int consumedKcal;

  const HealthProgressHeader({
    super.key,
    required this.consumedKcal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Health',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                text: 'You have consumed ',
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(
                    text: '$consumedKcal kcal',
                    style: TextStyle(fontSize: 16, color: MyColors.PrimaryBlue, fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: ' today',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}