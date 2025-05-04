import 'package:flutter/material.dart';
import 'package:fitness_app/utils/color_extension.dart';
import 'package:fitness_app/widgets/health_related_widgets/nutrient_info_row.dart';

class NutritionInfoSection extends StatelessWidget {
  final int fatGrams, dailyCalorieGoal;
  final int proteinGrams;
  final int carbsGrams;

  const NutritionInfoSection({
    super.key,
    required this.fatGrams,
    required this.proteinGrams,
    required this.carbsGrams,
    required this.dailyCalorieGoal,
  });

  // Updated max values
  static const int maxFat = 200;
  static const int maxProtein = 250;
  static const int maxCarbs = 400;

  int get fatPercent => ((fatGrams / maxFat) * 100).clamp(0, 100).toInt();
  int get proteinPercent => ((proteinGrams / maxProtein) * 100).clamp(0, 100).toInt();
  int get carbsPercent => ((carbsGrams / maxCarbs) * 100).clamp(0, 100).toInt();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NutrientInfoRow(nutrient: "Fat", grams: fatGrams, percent: fatPercent, color: MyColors.chart_pink),
        NutrientInfoRow(nutrient: "Protein", grams: proteinGrams, percent: proteinPercent, color: MyColors.chart_orange),
        NutrientInfoRow(nutrient: "Carbs", grams: carbsGrams, percent: carbsPercent, color: MyColors.chart_blue),
      ],
    );
  }
}