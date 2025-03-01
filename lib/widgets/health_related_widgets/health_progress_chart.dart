import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_projects_1/color_extension.dart'; // Make sure this import is correct.

class MultiRingCircularChart extends StatelessWidget {
  final double fatProgress;
  final double proteinProgress;
  final double carbsProgress;
  final double totalProgress;
  final int totalCalories;

  const MultiRingCircularChart({
    super.key,
    required this.fatProgress,
    required this.proteinProgress,
    required this.carbsProgress,
    required this.totalProgress,
    required this.totalCalories,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: 300,  // Increased from 250
          height: 300, // Increased from 250
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Carbs ring - outer (Blue)
              CircularPercentIndicator(
                radius: 130.0,  // Increased
                lineWidth: 16.0,  // Optional - make ring thicker if desired
                percent: carbsProgress,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: MyColors.chart_blue,
                backgroundColor: Colors.grey[200]!,
              ),
              // Protein ring - middle (Orange)
              CircularPercentIndicator(
                radius: 110.0,  // Increased
                lineWidth: 16.0,
                percent: proteinProgress,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: MyColors.chart_orange,
                backgroundColor: Colors.grey[200]!,
              ),
              // Fat ring - inner (Pink)
              CircularPercentIndicator(
                radius: 90.0,  // Increased
                lineWidth: 16.0,
                percent: fatProgress,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: MyColors.chart_pink,
                backgroundColor: Colors.grey[200]!,
              ),
              // Center Text (bigger empty circle area for text)
              Container(
                width: 140,  // Increased for balance
                height: 140,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${(totalProgress * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 32,  // Optional: make the text slightly bigger
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'of $totalCalories kcal',
                      style: TextStyle(
                        fontSize: 16,  // Optional: make this slightly bigger
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
