import 'package:flutter/material.dart';

class StepsHeader extends StatelessWidget {
  const StepsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Steps",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8), 
        const Text(
          "You have achieved",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        RichText(
          text:const TextSpan(
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: "80% ",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              TextSpan(text: "of your goal"),
            ],
          ),
        ),
        const Text(
          "today",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}