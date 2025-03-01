import 'package:flutter/material.dart';
import 'package:flutter_projects_1/widgets/health_related_widgets/nutrient_info_row.dart';
import 'package:flutter_projects_1/color_extension.dart';

class NutritionInfoSection extends StatelessWidget {
  const NutritionInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const SizedBox(height: 16),
        NutrientInfoRow(
          nutrient: "Fat",
          grams: "80g",
          percent: "40%",
          color: MyColors.chart_pink,
        ),
        const SizedBox(height: 8),
        NutrientInfoRow(
          nutrient: "Protein",
          grams: "160g",
          percent: "56%",
          color: MyColors.chart_orange,
        ),
        const SizedBox(height: 8),
        NutrientInfoRow(
          nutrient: "Carbs",
          grams: "230g",
          percent: "62%",
          color: MyColors.chart_blue,
        ),
      ],
    );
  }
}