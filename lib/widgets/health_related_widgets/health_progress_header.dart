import 'package:flutter/material.dart';
import 'package:fitness_app/utils/color_extension.dart';

class HealthProgressHeader extends StatelessWidget {
  final int consumedKcal;
  final int dailyCalorieGoal;

  static const int fixedChartGoal = 2000; // Fixed reference for the chart

  const HealthProgressHeader({
    super.key,
    required this.consumedKcal,
    required this.dailyCalorieGoal,
  });

  @override
  Widget build(BuildContext context) {
    double percentageOfUserGoal = (consumedKcal / dailyCalorieGoal) * 100;
    double percentageOfChartGoal = (consumedKcal / fixedChartGoal) * 100;
    bool exceededGoal = consumedKcal > dailyCalorieGoal;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Health',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  const TextSpan(text: 'You have consumed '),
                  TextSpan(
                    text: '$consumedKcal kcal',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: exceededGoal ? Colors.red : MyColors.PrimaryBlue,
                    ),
                  ),
                  const TextSpan(text: ' today.\n'),
                  TextSpan(
                    text: exceededGoal
                        ? 'You have exceeded your goal!'
                        : 'Keep going to reach your goal!',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: exceededGoal ? Colors.red : MyColors.PrimaryBlue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '${percentageOfChartGoal.toStringAsFixed(1)}% of $fixedChartGoal kcal',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: exceededGoal ? Colors.red : Colors.black,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}