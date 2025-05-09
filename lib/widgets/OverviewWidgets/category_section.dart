import 'package:fitness_app/screens/health_screen.dart';
import 'package:fitness_app/screens/steps_page.dart';
import 'package:fitness_app/screens/sleep_page.dart';
import 'package:flutter/material.dart';
import 'category_icon.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Category",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StepsPage()),
                );
              },
              child: const CategoryIcon(imagePath: "assets/images/steps_icon.jpg", label: "Steps"),
            ),
            const CategoryIcon(imagePath: "assets/images/workout_icon.jpg", label: "Workout"),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HealthScreen()),
                );
              },
              child: const CategoryIcon(imagePath: "assets/images/health_icon.jpg", label: "Health"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SleepPage()),
                );
              },
              child: const CategoryIcon(imagePath: "assets/images/sleep_icon.jpg", label: "Sleep"),
            ),
          ],
        ),
      ],
    );
  }
}
