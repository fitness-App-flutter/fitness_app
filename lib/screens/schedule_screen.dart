import 'package:flutter/material.dart';
import 'package:fitness_app/core/utils/schedule_logic.dart';

enum ScheduleType { sleep, wake }

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
}

class ScheduleScreen extends StatefulWidget {
  final String title;
  final ScheduleType type;

  const ScheduleScreen({super.key, required this.title, required this.type});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final ScheduleLogic _logic = ScheduleLogic();
  final String _userId = 'userId';

  SleepScheduleData _sleepData = SleepScheduleData(
    sleepTimes: {
      'Saturday': const TimeOfDay(hour: 6, minute: 0),
      'Sunday': const TimeOfDay(hour: 6, minute: 0),
      'Monday': const TimeOfDay(hour: 8, minute: 0),
      'Tuesday': const TimeOfDay(hour: 7, minute: 0),
      'Wednesday': const TimeOfDay(hour: 8, minute: 0),
      'Thursday': const TimeOfDay(hour: 12, minute: 0),
      'Friday': const TimeOfDay(hour: 12, minute: 0),
    },
    wakeTimes: {
      'Saturday': const TimeOfDay(hour: 7, minute: 30),
      'Sunday': const TimeOfDay(hour: 7, minute: 30),
      'Monday': const TimeOfDay(hour: 7, minute: 30),
      'Tuesday': const TimeOfDay(hour: 7, minute: 30),
      'Wednesday': const TimeOfDay(hour: 7, minute: 30),
      'Thursday': const TimeOfDay(hour: 7, minute: 30),
      'Friday': const TimeOfDay(hour: 7, minute: 30),
    },
  );

  @override
  void initState() {
    super.initState();
    _loadSchedule();
  }

  Future<void> _loadSchedule() async {
    final sleepData = await _logic.loadSchedule(userId: _userId, type: 'sleep');
    final wakeData = await _logic.loadSchedule(userId: _userId, type: 'wake');

    setState(() {
      _sleepData = SleepScheduleData(
        sleepTimes: sleepData.isNotEmpty ? sleepData : _sleepData.sleepTimes,
        wakeTimes: wakeData.isNotEmpty ? wakeData : _sleepData.wakeTimes,
      );
    });
  }

  Future<void> _pickTime(String day) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: widget.type == ScheduleType.sleep
          ? _sleepData.sleepTimes[day]!
          : _sleepData.wakeTimes[day]!,
    );

    if (picked != null) {
      setState(() {
        if (widget.type == ScheduleType.sleep) {
          _sleepData.sleepTimes[day] = picked;
        } else {
          _sleepData.wakeTimes[day] = picked;
        }
      });

      await _logic.saveSchedule(
        userId: _userId,
        type: widget.type.name,
        times: widget.type == ScheduleType.sleep
            ? _sleepData.sleepTimes
            : _sleepData.wakeTimes,
      );

      final Map<String, double> durations = {};
      for (var entry in _sleepData.sleepTimes.entries) {
        final duration = _sleepData.getSleepDuration(entry.key);
        durations[entry.key] = duration.inMinutes / 60.0;
      }

      await _logic.saveSleepData(
        userId: _userId,
        sleepTimes: _sleepData.sleepTimes,
        wakeTimes: _sleepData.wakeTimes,
        sleepDurations: durations,
      );
    }
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }

  Color _getDurationColor(Duration duration) {
    final totalHours = duration.inHours;
    if (totalHours >= 7 && totalHours <= 9) {
      return Colors.green;
    } else if (totalHours >= 5 && totalHours < 7) {
      return Colors.orange;
    } else if (totalHours > 9) {
      return Colors.blue;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: _sleepData.sleepTimes.keys.map((day) {
          final sleepDuration = _sleepData.getSleepDuration(day);
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                day,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.nightlight_round, size: 16),
                      const SizedBox(width: 4),
                      Text(' ${_sleepData.sleepTimes[day]!.format(context)}'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.alarm, size: 16),
                      const SizedBox(width: 4),
                      Text(' ${_sleepData.wakeTimes[day]!.format(context)}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getDurationColor(sleepDuration).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          _formatDuration(sleepDuration),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _getDurationColor(sleepDuration),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _pickTime(day),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
