import 'package:flutter/material.dart';

class NutrientInfoRow extends StatelessWidget {
  final String nutrient;
  final String grams;
  final String percent;
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
            radius: 12,  // Adjust to your desired size
          ),

          const SizedBox(width: 12),

          // Nutrient name (left-aligned)
          Expanded(
            flex: 3,  // Space for nutrient name
            child: Text(
              nutrient,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Grams (perfectly centered column)
          Expanded(
            flex: 3,  // Space for grams
            child: Center(
              child: Text(
                grams,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Percentage (right-aligned)
          Expanded(
            flex: 3,  // Space for percentage
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                percent,
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
