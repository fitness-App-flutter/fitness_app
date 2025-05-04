import 'package:flutter/material.dart';
import 'package:fitness_app/widgets/health_related_widgets/nutrient_provider.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/core/utils/color_extension.dart';

class SubmitMealButton extends StatelessWidget {
  final String type;
  final double value;

  const SubmitMealButton({
    super.key,
    required this.type,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final nutrientProvider = Provider.of<NutrientProvider>(context, listen: false);
        nutrientProvider.updateNutrient(type, value); // Now correctly passing type & value

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Meal data saved successfully!"),
            duration: Duration(seconds: 2),
          ),
        );

        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.PrimaryBlue,
        foregroundColor: MyColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        minimumSize: const Size(400, 10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.rice_bowl_outlined, color: Colors.white),
          const SizedBox(width: 5),
          const Text(
            "Submit meals",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}