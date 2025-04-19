import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  final String imagePath;
  final String label;

  const CategoryIcon({super.key, required this.imagePath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.cover),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
