import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:fitness_app/utils/color_extension.dart';

class MultiRingCircularChart extends StatelessWidget {
  final int fatGrams;
  final int proteinGrams;
  final int carbsGrams;
  final int totalCalories;
  final int dailyCalorieGoal;

  const MultiRingCircularChart({
    super.key,
    required this.fatGrams,
    required this.proteinGrams,
    required this.carbsGrams,
    required this.totalCalories,
    required this.dailyCalorieGoal,
  });

  static const int maxFat = 200;
  static const int maxProtein = 250;
  static const int maxCarbs = 400;

  double get fatProgress => (fatGrams / maxFat).clamp(0.0, 1.0);
  double get proteinProgress => (proteinGrams / maxProtein).clamp(0.0, 1.0);
  double get carbsProgress => (carbsGrams / maxCarbs).clamp(0.0, 1.0);

  double get percentage => ((totalCalories / dailyCalorieGoal) * 100).clamp(0.0, 999.9);
  bool get exceededGoal => percentage > 100;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 260,
        height: 260,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularPercentIndicator(
              radius: 110.0,
              lineWidth: 14.0,
              percent: carbsProgress,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: MyColors.chart_blue,
              backgroundColor: Colors.grey[200]!,
            ),
            CircularPercentIndicator(
              radius: 90.0,
              lineWidth: 14.0,
              percent: proteinProgress,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: MyColors.chart_orange,
              backgroundColor: Colors.grey[200]!,
            ),
            CircularPercentIndicator(
              radius: 70.0,
              lineWidth: 14.0,
              percent: fatProgress,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: MyColors.chart_pink,
              backgroundColor: Colors.grey[200]!,
            ),
            Container(
              width: 120,
              height: 120,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${percentage.toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: exceededGoal ? Colors.red : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$totalCalories kcal',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: exceededGoal ? Colors.red : MyColors.PrimaryBlue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
