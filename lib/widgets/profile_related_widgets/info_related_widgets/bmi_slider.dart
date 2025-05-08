import 'package:flutter/material.dart';

class BmiIndicator extends StatelessWidget {
  final double heightCm;
  final double weightKg;

  const BmiIndicator({
    super.key,
    required this.heightCm,
    required this.weightKg,
  });

  double calculateBmi() {
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  @override
  Widget build(BuildContext context) {
    final bmi = calculateBmi().clamp(10.0, 40.0);
    const bmiMin = 10.0;
    const bmiMax = 40.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "BMI Indicator",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        LayoutBuilder(
          builder: (context, constraints) {
            final barWidth = constraints.maxWidth;
            final relativeBmi = ((bmi - bmiMin) / (bmiMax - bmiMin)).clamp(0.0, 1.0);
            final arrowPosition = relativeBmi * barWidth;

            return Stack(
              clipBehavior: Clip.none,
              children: [
                // Gradient Bar
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.blue,
                        Colors.green,
                        Colors.orange,
                        Colors.red,
                      ],
                      stops: [0.0, 0.5, 0.75, 1.0],
                    ),
                  ),
                  child: Stack(
                    children: const [
                      // Min BMI Label
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '10.0',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Max BMI Label
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '40.0',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Arrow & BMI value
                Positioned(
                  left: arrowPosition.clamp(0, barWidth - 40),
                  top: -35, // move arrow + label above the bar
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          bmi.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_drop_down,
                        size: 30,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),

      ],
    );
  }
}
