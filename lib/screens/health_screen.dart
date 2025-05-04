import 'package:flutter/material.dart';
import 'package:fitness_app/core/utils/color_extension.dart';
import 'package:fitness_app/widgets/health_related_widgets/nutrition_info_section.dart';
import 'package:provider/provider.dart';
import 'add_meal_screen.dart';
import 'package:fitness_app/widgets/health_related_widgets/health_progress_chart.dart';
import 'package:fitness_app/widgets/health_related_widgets/add_meal_button.dart';
import 'package:fitness_app/widgets/health_related_widgets/nutrient_provider.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nutrientProvider = Provider.of<NutrientProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Health",
          style: TextStyle(
            color: Colors.black,
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
                    text: "${nutrientProvider.totalCalories.toStringAsFixed(0)} kcal",
                    style: TextStyle(color: MyColors.PrimaryBlue),
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
              fatGrams: nutrientProvider.fat,
              proteinGrams: nutrientProvider.protein,
              carbsGrams: nutrientProvider.carbs,
              totalCalories: nutrientProvider.totalCalories.toInt(),
              dailyCalorieGoal: 2000,
            ),


            const SizedBox(height: 40),


            NutritionInfoSection(
              fatGrams: nutrientProvider.fat,
              proteinGrams: nutrientProvider.protein,
              carbsGrams: nutrientProvider.carbs,
              dailyCalorieGoal: 2000,
            ),

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
