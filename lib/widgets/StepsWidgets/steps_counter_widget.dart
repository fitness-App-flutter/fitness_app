import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/core/utils/step_counter_logic.dart';
import 'package:fitness_app/widgets/StepsWidgets/steps_progress.dart';

class StepsCounterScreen extends StatelessWidget {
  const StepsCounterScreen({super.key});
  final int dailyGoal = 18000;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Consumer<StepCounterLogic>(
            builder: (context, stepLogic, child) {
              if (!stepLogic.isDataLoaded) {
                return const CircularProgressIndicator();
              }

              return StepsProgress(
                steps: stepLogic.stepsToday,
                goal: dailyGoal,
              );
            },
          ),
        ),
      ),
    );
  }
}
