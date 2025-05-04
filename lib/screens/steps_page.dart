import 'package:fitness_app/widgets/StepsWidgets/steps_chart.dart';
import 'package:fitness_app/widgets/StepsWidgets/steps_counter_widget.dart';
import 'package:fitness_app/widgets/StepsWidgets/steps_header.dart';
import 'package:fitness_app/widgets/StepsWidgets/steps_statistics.dart';
import 'package:flutter/material.dart';

class StepsPage extends StatelessWidget {
  const StepsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StepsHeader(),
                 SizedBox(height: 20),
                SizedBox(
                  height: 220,
                  child:  StepsCounterScreen(),
                ),
                 SizedBox(height: 20),
                 StepsStatistics(),
                 SizedBox(height: 20),
                SizedBox(
                  height: 300,
                  child:  StepsChart(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
