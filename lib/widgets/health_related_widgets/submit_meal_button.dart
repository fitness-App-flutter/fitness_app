import 'package:flutter/material.dart';
import 'package:flutter_projects_1/color_extension.dart';

class SubmitMealButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SubmitMealButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.PrimaryBlue,
          foregroundColor: MyColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          minimumSize: const Size(400, 10),  // Same size for both buttons
        ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.rice_bowl_outlined, color: Colors.white),
          const SizedBox(width: 5),
          const Text(
            "Submit meals",
            style: TextStyle(
              fontWeight: FontWeight.bold,    // Make text bold
              fontSize: 20,                    // Set font size
            ),
          ),
        ],
      ),
    );
  }
}
