import 'package:flutter/material.dart';
import 'package:flutter_projects_1/color_extension.dart';
import 'package:flutter_projects_1/widgets/health_related_widgets/submit_meal_button.dart';
import 'package:flutter_projects_1/widgets/health_related_widgets/nutrient_slider_row.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  double fat = 0;
  double protein = 0;
  double carbs = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text.rich(
          TextSpan(
            text: 'Add Meals of the ',
            style : TextStyle(fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: 'DAY',
                style: TextStyle(color: MyColors.PrimaryBlue, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Add extra padding to the first slider
            Padding(
              padding: const EdgeInsets.only(top: 25), // Adjust this value as needed
              child: NutrientSliderRow(
                nutrient: "Fat",
                value: fat,
                color: MyColors.chart_pink,
                tooltipColor: MyColors.chart_pink.withOpacity(0.8), // Custom tooltip color
                onChanged: (v) => setState(() => fat = v),
              ),
            ),
            const SizedBox(height: 16),

            // Protein Slider
            NutrientSliderRow(
              nutrient: "Protein",
              value: protein,
              color: MyColors.chart_orange,
              tooltipColor: MyColors.chart_orange.withOpacity(0.8), // Custom tooltip color
              onChanged: (v) => setState(() => protein = v),
            ),
            const SizedBox(height: 16),

            // Carbs Slider
            NutrientSliderRow(
              nutrient: "Carbs",
              value: carbs,
              color: MyColors.chart_blue,
              tooltipColor: MyColors.chart_blue.withOpacity(0.8), // Custom tooltip color
              onChanged: (v) => setState(() => carbs = v),
            ),

            const Spacer(),
            SubmitMealButton(
              onPressed: () {
                Navigator.pop(context); // Go back without showing a message
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}