import 'package:flutter/material.dart';
import 'category_icon.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Category",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CategoryIcon(imagePath: "assets/images/steps_icon.jpg", label: "Steps"),
            CategoryIcon(imagePath: "assets/images/workout_icon.jpg", label: "Workout"),
            CategoryIcon(imagePath: "assets/images/health_icon.jpg", label: "Health"),
          ],
        ),
      ],
    );
  }
}
