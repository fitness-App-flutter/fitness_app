import 'package:flutter/material.dart';

class StepDisplayWidget extends StatelessWidget {
  final int stepCount;

  const StepDisplayWidget({super.key, required this.stepCount});

  @override
  Widget build(BuildContext context) {
    return Text(
      "$stepCount",
      style: const TextStyle(
        fontSize: 100,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
    );
  }
}