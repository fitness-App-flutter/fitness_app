import 'package:fitness_app/core/utils/step_counter_logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'stat_item.dart';

class StepsStatistics extends StatelessWidget {
  const StepsStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    final stepCounter = Provider.of<StepCounterLogic>(context);

    final distanceInKm = (stepCounter.distanceToday / 1000).toStringAsFixed(1);
    final goalInKm = stepCounter.formattedDailyDistanceGoal;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StatItem(
          icon: Icons.local_fire_department,
          iconColor: const Color(0xff7f55E0),
          percent: 0.75,
          value: "850 kcal",
        ),
        StatItem(
          icon: Icons.location_on,
          iconColor: const Color(0xffEA916E),
          percent: stepCounter.distanceProgress,
          value: "$distanceInKm km",
        ),
        StatItem(
          icon: Icons.access_time,
          iconColor: const Color(0xff636AE8),
          percent: 0.85,
          value: "120 min",
        ),
      ],
    );
  }
}