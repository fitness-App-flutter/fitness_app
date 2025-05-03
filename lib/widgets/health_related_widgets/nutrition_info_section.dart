import 'package:flutter/material.dart';
import 'package:fitness_app/utils/color_extension.dart';
import 'package:fitness_app/widgets/health_related_widgets/nutrient_info_row.dart';

class NutritionInfoSection extends StatelessWidget {
  final double fatGrams, dailyCalorieGoal;
  final double proteinGrams;
  final double carbsGrams;

  const NutritionInfoSection({
    super.key,
    required this.fatGrams,
    required this.proteinGrams,
    required this.carbsGrams,
    required this.dailyCalorieGoal,
  });

  // Updated max values
  static const double maxFat = 200;
  static const double maxProtein = 250;
  static const double maxCarbs = 400;

  double get fatPercent => (fatGrams / maxFat).clamp(0.0, 1.0);
  double get proteinPercent => (proteinGrams / maxProtein).clamp(0.0, 1.0);
  double get carbsPercent => (carbsGrams / maxCarbs).clamp(0.0, 1.0);

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