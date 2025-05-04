import 'package:fitness_app/auth/views/sign_up_screen.dart';
import 'package:fitness_app/auth/widges/curved_container.dart';
import 'package:fitness_app/auth/widges/custom_button.dart';
import 'package:flutter/material.dart';

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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  const SizedBox(height: 10,),
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child:SizedBox(width: 50,child: Image(image: AssetImage("assets/images/shose.png"),),)
                  ),
                  const SizedBox(height: 10),
                  // Text
                  Text(
                    "Let's start your health journey today with us!",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Continue Button
                  CustomButton(
                    text: "Continue",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}