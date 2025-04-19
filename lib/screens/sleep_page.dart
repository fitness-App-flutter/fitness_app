import 'package:fitness_app/widgets/SleepWidgets/sleep_chart.dart';
import 'package:fitness_app/widgets/SleepWidgets/sleep_header.dart';
import 'package:fitness_app/widgets/SleepWidgets/sleep_schedule.dart';
import 'package:fitness_app/widgets/SleepWidgets/sleep_statistics.dart';
import 'package:flutter/material.dart';

class SleepPage extends StatelessWidget {
  const SleepPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SleepHeader(),
              SizedBox(height: 20),
              SleepChart(),
              SizedBox(height: 20),
              SleepStatistics(),
              SizedBox(height: 20),
              SleepSchedule(),
            ],
          ),
        ),
      ),
    );
  }
}
