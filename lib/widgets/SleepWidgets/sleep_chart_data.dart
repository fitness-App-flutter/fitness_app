import 'package:fitness_app/core/utils/schedule_logic.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

final ScheduleLogic _scheduleLogic = ScheduleLogic();
final String _userId = 'userId';

Future<List<double>> getRealSleepData() async {
  try {
    final durations = await _scheduleLogic.loadSleepDurations(userId: _userId);
    return [
      durations['Saturday'] ?? 0,
      durations['Sunday'] ?? 0,
      durations['Monday'] ?? 0,
      durations['Tuesday'] ?? 0,
      durations['Wednesday'] ?? 0,
      durations['Thursday'] ?? 0,
      durations['Friday'] ?? 0,
    ];
  } catch (e) {
    print('Error fetching sleep data: $e');
    return [0, 0, 0, 0, 0, 0, 0];
  }
}

List<String> getWeeklyLabels() {
  return ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
}

List<BarChartGroupData> getBarGroups(
    int? touchedIndex, Function(int) onBarTap, List<double> sleepData) {
  return List.generate(sleepData.length, (index) {
    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: sleepData[index],
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