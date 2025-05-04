import 'package:fitness_app/core//utils/step_counter_logic.dart';
import 'package:fitness_app/widgets/StepsWidgets/steps_progress.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class StepsCounterScreen extends StatefulWidget {
  const StepsCounterScreen({super.key});

  @override
  State<StepsCounterScreen> createState() => _StepsCounterScreenState();
}

class _StepsCounterScreenState extends State<StepsCounterScreen> {
  final StepCounterLogic _logic = StepCounterLogic();
  final int dailyGoal = 18000;

  @override
  void initState() {
    super.initState();
    _logic.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<AccelerometerEvent>(
                stream: SensorsPlatform.instance.accelerometerEventStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _logic.updateSteps(snapshot.data!);
                    return StepsProgress(
                      steps: _logic.steps,
                      goal: dailyGoal,
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
