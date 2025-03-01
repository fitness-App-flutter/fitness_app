import 'package:flutter/material.dart';
import 'package:flutter_projects_1/color_extension.dart';
import 'package:flutter_projects_1/widgets/health_related_widgets/nutrition_info_section.dart';
import 'add_meal_screen.dart';
import 'package:flutter_projects_1/widgets/health_related_widgets/health_progress_chart.dart';
import 'package:flutter_projects_1/widgets/health_related_widgets/add_meal_button.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double totalKcal = 1300; // Daily target
    double consumedKcal = 960;
    double progress = consumedKcal / totalKcal; // 960 out of 1300 kcal

    return Scaffold(
      backgroundColor: Colors.white,  // This makes the whole screen white.
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Optional: Remove shadow for cleaner design
        leading: const Icon(Icons.arrow_back_ios, color: Colors.black), // Ensure the icon is visible on white
        title: const Text(
          "Health",
          style: TextStyle(
            color: Colors.black, // Text color to match the clean white theme
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                children: [
                  const TextSpan(
                    text: "You have consumed\n",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: "960 kcal",
                    style: TextStyle(color: MyColors.PrimaryBlue), // Replace with your actual primary blue color
                  ),
                  const TextSpan(
                    text: " today",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            MultiRingCircularChart(
              fatProgress: 0.4,
              proteinProgress: 0.56,
              carbsProgress: 0.75,
              totalProgress: 0.6,
              totalCalories: 1300,
            ),

            const SizedBox(height: 40),
           NutritionInfoSection(),

            const Spacer(),
            AddMealButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddMealScreen()),
                );
              },
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
