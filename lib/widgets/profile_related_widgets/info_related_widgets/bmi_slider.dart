import 'dart:math';
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

  String getBmiCategoryGif(double bmi) {
    if (bmi < 18.5) {
      return 'assets/images/bmi_underweight.gif';
    } else if (bmi < 25) {
      return 'assets/images/bmi_normal.gif';
    } else if (bmi < 30) {
      return 'assets/images/bmi_overweight.gif';
    } else {
      return 'assets/images/bmi_obese.gif';
    }
  }

  String getRandomQuote(double bmi) {
    final random = Random();
    if (bmi < 18.5) {
      final quotes = [
        "You are stronger than you think.",
        "Small steps every day lead to big changes.",
        "Fuel your body, fuel your life.",
      ];
      return quotes[random.nextInt(quotes.length)];
    } else if (bmi < 25) {
      final quotes = [
        "Health is wealth. Keep it up!",
        "Balance is the key to a healthy life.",
        "Your body is your temple – keep it strong.",
      ];
      return quotes[random.nextInt(quotes.length)];
    } else if (bmi < 30) {
      final quotes = [
        "Start where you are. Use what you have. Do what you can.",
        "One workout at a time, one meal at a time.",
        "Your journey to health starts with a single step.",
      ];
      return quotes[random.nextInt(quotes.length)];
    } else {
      final quotes = [
        "Every day is a new chance to improve.",
        "Don’t give up – great things take time.",
        "You are capable of amazing change.",
      ];
      return quotes[random.nextInt(quotes.length)];
    }
  }

  @override
  Widget build(BuildContext context) {
    final bmi = calculateBmi().clamp(10.0, 40.0);
    final gifPath = getBmiCategoryGif(bmi);
    final quote = getRandomQuote(bmi);
    const bmiMin = 10.0;
    const bmiMax = 40.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "BMI Indicator",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 20),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final barWidth = constraints.maxWidth;
            final relativeBmi =
            ((bmi - bmiMin) / (bmiMax - bmiMin)).clamp(0.0, 1.0);
            final arrowPosition = relativeBmi * barWidth;

            return Stack(
              clipBehavior: Clip.none,
              children: [
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
                Positioned(
                  left: arrowPosition.clamp(0, barWidth - 40),
                  top: -35,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
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
        const SizedBox(height: 20),
        Center(
          child: Column(
            children: [
              Image.asset(
                gifPath,
                height: 150,
                fit: BoxFit.contain,
                gaplessPlayback: true,
              ),
              const SizedBox(height: 10),
              Text(
                quote,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
