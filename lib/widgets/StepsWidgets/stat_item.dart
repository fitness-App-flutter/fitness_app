import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StatItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double percent;
  final String value;

  const StatItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.percent,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 35.0,
          lineWidth: 6.0,
          percent: percent,
          center: Icon(icon, size: 24, color: iconColor),
          progressColor: iconColor,
          backgroundColor: iconColor.withOpacity(0.2),
          circularStrokeCap: CircularStrokeCap.round,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
