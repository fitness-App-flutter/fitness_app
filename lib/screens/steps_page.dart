import 'package:fitness_app/widgets/StepsWidgets/steps_chart.dart';
import 'package:fitness_app/widgets/StepsWidgets/steps_counter_widget.dart';
import 'package:fitness_app/widgets/StepsWidgets/steps_header.dart';
import 'package:fitness_app/widgets/StepsWidgets/steps_statistics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/core/utils/step_counter_logic.dart';

class StepsPage extends StatelessWidget {
  const StepsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Consumer<StepCounterLogic>(
              builder: (context, stepLogic, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StepsHeader(stepsToday: stepLogic.stepsToday),
                    const SizedBox(height: 20),
                    const SizedBox(
                      height: 220,
                      child: StepsCounterScreen(),
                    ),
                    const SizedBox(height: 20),
                    const StepsStatistics(),
                    const SizedBox(height: 20),
                    const SizedBox(
                      height: 300,
                      child: StepsChart(),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
