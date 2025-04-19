import 'package:flutter/material.dart';
import 'stat_item.dart';

class StepsStatistics extends StatelessWidget {
  const StepsStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:  [
        StatItem(
          icon: Icons.local_fire_department,
          iconColor: Color(0xff7f55E0),
          percent: 0.75,
          value: "850 kcal",
        ),
        StatItem(
          icon: Icons.location_on,
          iconColor: Color(0xffEA916E),
          percent: 0.6,
          value: "5 km",
        ),
        StatItem(
          icon: Icons.access_time,
          iconColor: Color(0xff636AE8),
          percent: 0.85,
          value: "120 min",
        ),
      ],
    );
  }
}
