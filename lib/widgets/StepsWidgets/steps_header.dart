import 'package:flutter/material.dart';

class StepsHeader extends StatelessWidget {
  final int stepsToday;
  final int goal;

  const StepsHeader({
    super.key,
    required this.stepsToday,
    this.goal = 18000,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = (stepsToday / goal).clamp(0.0, 1.0);
    int percentDisplay = (percentage * 100).round();

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
          text: TextSpan(
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: "$percentDisplay% ",
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const TextSpan(text: "of your goal"),
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
