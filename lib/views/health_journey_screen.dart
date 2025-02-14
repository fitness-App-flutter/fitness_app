import 'package:flutter/material.dart';
import 'package:test_app/widgets/curved_container.dart';
import 'package:test_app/widgets/custom_button.dart';

class HealthJourneyScreen extends StatelessWidget {
  const HealthJourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/runner.jpg', // Replace with your image path
              fit: BoxFit.fill,
            ),
          ),
          // Curved Container with content
          CurvedContainer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.directions_run,
                    color: Colors.blueAccent,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 50),
                // Text
                const Text(
                  "Let's start your health journey today with us!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                // Continue Button
                CustomButton(
                  text: "Continue",
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
