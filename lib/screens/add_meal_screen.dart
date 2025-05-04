import 'package:flutter/material.dart';
import 'package:fitness_app/widgets/health_related_widgets/submit_meal_button.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/utils/color_extension.dart';
import 'package:fitness_app/widgets/health_related_widgets/nutrient_provider.dart';
import 'package:fitness_app/widgets/health_related_widgets/nutrient_slider_row.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddMealScreen extends StatelessWidget {
  const AddMealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nutrientProvider = Provider.of<NutrientProvider>(context);
    final currentUser = FirebaseAuth.instance.currentUser;


    if (currentUser == null) {
      return const Scaffold(
        body: Center(
          child: Text("User not logged in."),
        ),
      );
    }

    final userId = currentUser.uid;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text.rich(
          TextSpan(
            text: 'Add Meals of ',
            style: const TextStyle(fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: DateFormat('E d MMM').format(DateTime.now()),
                style: TextStyle(
                  color: MyColors.PrimaryBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: NutrientSliderRow(
                nutrient: "Fat",
                value: nutrientProvider.fat,
                color: MyColors.chart_pink,
                tooltipColor: MyColors.chart_pink.withOpacity(0.8),
                onChanged: (v) => nutrientProvider.updateNutrient("Fat", v - nutrientProvider.fat, userId),
              ),
            ),
            const SizedBox(height: 16),
            NutrientSliderRow(
              nutrient: "Protein",
              value: nutrientProvider.protein,
              color: MyColors.chart_orange,
              tooltipColor: MyColors.chart_orange.withOpacity(0.8),
              onChanged: (v) => nutrientProvider.updateNutrient("Protein", v - nutrientProvider.protein, userId),
            ),
            const SizedBox(height: 16),
            NutrientSliderRow(
              nutrient: "Carbs",
              value: nutrientProvider.carbs,
              color: MyColors.chart_blue,
              tooltipColor: MyColors.chart_blue.withOpacity(0.8),
              onChanged: (v) => nutrientProvider.updateNutrient("Carbs", v - nutrientProvider.carbs, userId),
            ),
            const Spacer(),
            SubmitMealButton(
              type: "Meal",
              value: nutrientProvider.fat + nutrientProvider.protein + nutrientProvider.carbs,
              userId: userId,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
