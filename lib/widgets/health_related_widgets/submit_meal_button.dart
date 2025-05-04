import 'package:flutter/material.dart';
import 'package:fitness_app/widgets/health_related_widgets/nutrient_provider.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/utils/color_extension.dart';

class SubmitMealButton extends StatelessWidget {
  final String type;
  final int value;
  final String userId;

  const SubmitMealButton({
    super.key,
    required this.type,
    required this.value,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final nutrientProvider = Provider.of<NutrientProvider>(context, listen: false);
        await nutrientProvider.updateNutrient(type, value, userId);

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
        children: const [
          Icon(Icons.rice_bowl_outlined, color: Colors.white),
          SizedBox(width: 5),
          Text(
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
