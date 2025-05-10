import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<double> getWeeklySleepData() {
  return [6.5, 7.0, 6.8, 7.2, 6.5, 8.0, 7.5];
}

List<String> getWeeklyLabels() {
  return [ 'Sat', 'Sun','Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
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
