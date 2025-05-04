import 'package:flutter/material.dart';
import 'package:fitness_app/core/utils/color_extension.dart';

class ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0), // Add left padding here
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 16, color: MyColors.PrimaryBlue),
            ),
            const SizedBox(width: 10),
            Text(
              value,
              style: TextStyle(fontSize: 16, color: MyColors.black),
            ),
          ],
        ),
      ),
    );
  }
}