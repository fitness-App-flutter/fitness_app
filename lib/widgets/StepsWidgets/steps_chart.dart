// lib/widgets/StepsWidgets/steps_chart.dart
import 'package:flutter/material.dart';
import 'package:fitness_app/widgets/StepsWidgets/period_selector.dart';
import 'package:fitness_app/widgets/StepsWidgets/steps_line_chart.dart';

class StepsChart extends StatefulWidget {
  const StepsChart({super.key});
  @override
  _StepsChartState createState() => _StepsChartState();
}

class _StepsChartState extends State<StepsChart> {
  String selectedPeriod = 'Today';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff888CED),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: Column(
        children: [
          PeriodSelector(
            selectedPeriod: selectedPeriod,
            onPeriodChanged: (newPeriod) {
              setState(() {
                selectedPeriod = newPeriod;
              });
            },
          ),
          const SizedBox(height: 16),
          Expanded(child: StepsLineChart(period: selectedPeriod)),
        ],
      ),
    );
  }
}