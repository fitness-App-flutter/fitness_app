import 'package:flutter/material.dart';

class SleepScheduleData {
  final Map<String, TimeOfDay> sleepTimes;
  final Map<String, TimeOfDay> wakeTimes;

  SleepScheduleData({
    required this.sleepTimes,
    required this.wakeTimes,
  });

  Duration getSleepDuration(String day) {
    final bedtime = sleepTimes[day]!;
    final wakeTime = wakeTimes[day]!;

    final now = DateTime.now();
    final bedtimeDateTime = DateTime(now.year, now.month, now.day, bedtime.hour, bedtime.minute);
    final wakeDateTime = DateTime(now.year, now.month, now.day, wakeTime.hour, wakeTime.minute);

    if (wakeDateTime.isBefore(bedtimeDateTime)) {
      return wakeDateTime.add(const Duration(days: 1)).difference(bedtimeDateTime);
    } else {
      return wakeDateTime.difference(bedtimeDateTime);
    }
  }

  double getAverageSleepDuration() {
    double totalHours = 0;
    for (var day in sleepTimes.keys) {
      totalHours += getSleepDuration(day).inMinutes / 60.0;
    }
    return totalHours / sleepTimes.length;
  }

  String formatAverageDuration() {
    final averageHours = getAverageSleepDuration();
    final hours = averageHours.floor();
    final minutes = ((averageHours - hours) * 60).round();
    return '${hours}h ${minutes}m';
  }
}