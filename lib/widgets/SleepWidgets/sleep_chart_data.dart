import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<double> getSleepDataForPeriod(String period) {
  switch (period) {
    case 'Today':
      return [1, 5.0, 7.2, 6.8, 5.5, 8.0, 7.0];
    case 'Weekly':
      return [6.5, 7.0, 6.8, 7.2, 6.5, 8.0, 7.5];
    case 'Monthly':
      return [7.0, 6.8, 7.2, 6.5];
    default:
      return [1, 5.0, 7.2, 6.8, 5.5, 8.0, 7.0];
  }
}

List<String> getLabelsForPeriod(String period) {
  switch (period) {
    case 'Today':
      return ['6AM', '9AM', '12PM', '3PM', '6PM', '9PM', '12AM'];
    case 'Weekly':
      return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    case 'Monthly':
      return ['Week1', 'Week2', 'Week3', 'Week4'];
    default:
      return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  }
}

List<BarChartGroupData> getBarGroups(
    int? touchedIndex, Function(int) onBarTap, List<double> sleepData) {
  return List.generate(sleepData.length, (index) {
    double sleepHours = sleepData[index];

    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: sleepHours,
          width: 20,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: touchedIndex == index
              ? const Color(0xff878CED)
              : const Color(0xffCED0F7),
        ),
      ],
    );
  });
}
