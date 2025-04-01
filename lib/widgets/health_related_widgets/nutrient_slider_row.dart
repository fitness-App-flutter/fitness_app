import 'package:flutter/material.dart';
import 'custom_slider.dart';

class NutrientSliderRow extends StatelessWidget {
  final String nutrient;
  final double value;
  final ValueChanged<double> onChanged;
  final Color color;
  final Color tooltipColor;

  const NutrientSliderRow({
    super.key,
    required this.nutrient,
    required this.value,
    required this.onChanged,
    required this.color,
    required this.tooltipColor,
  });

  // Set different max values based on nutrient type
  double get maxValue {
    switch (nutrient.toLowerCase()) {
      case "fat":
        return 150.0;
      case "protein":
        return 250.0;
      case "carbs":
        return 400.0;
      default:
        return 100.0; // Default fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Nutrient Name with Circle Indicator
          SizedBox(
            width: 120,
            child: Row(
              children: [
                CircleAvatar(radius: 12, backgroundColor: color),
                const SizedBox(width: 8),
                Text(
                  nutrient,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // Value Display Box
          Container(
            width: 60,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: color, width: 1.5),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              "${value.toInt()}g",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 16),

          // Custom Slider with adjusted max values
          Expanded(
            child: CustomSlider(
              value: value,
              min: 0.0,
              max: maxValue,
              onChanged: onChanged,
              color: color,
              tooltipColor: tooltipColor,
              tooltipFormatter: (value) => "${value.toInt()}g",
            ),
          ),
        ],
      ),
    );
  }
}