import 'package:flutter/material.dart';

class NutrientInfoRow extends StatelessWidget {
  final String nutrient;
  final double grams;
  final double percent;
  final Color color;

  const NutrientInfoRow({
    super.key,
    required this.nutrient,
    required this.grams,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 0.7,
        ),
      ),
      child: Row(
        children: [
          // Bigger colored circle
          CircleAvatar(
            backgroundColor: color,
            radius: 12,
          ),
          const SizedBox(width: 12),

          Expanded(
            flex: 3,
            child: Text(
              nutrient,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                "${grams.toStringAsFixed(1)} g",  // Convert double to string properly
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${(percent * 100).toStringAsFixed(1)}%",  // Convert to percentage
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}