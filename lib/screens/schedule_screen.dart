import 'package:flutter/material.dart';
import 'package:fitness_app/core/utils//schedule_logic.dart';

enum ScheduleType { sleep, wake }

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

  Map<String, TimeOfDay> scheduleTimes = {
    'Monday': const TimeOfDay(hour: 22, minute: 0),
    'Tuesday': const TimeOfDay(hour: 22, minute: 0),
    'Wednesday': const TimeOfDay(hour: 22, minute: 0),
    'Thursday': const TimeOfDay(hour: 22, minute: 0),
    'Friday': const TimeOfDay(hour: 22, minute: 0),
    'Saturday': const TimeOfDay(hour: 22, minute: 0),
    'Sunday': const TimeOfDay(hour: 22, minute: 0),
  };

  @override
  void initState() {
    super.initState();
    if (widget.type == ScheduleType.wake) {
      scheduleTimes.updateAll((key, value) => const TimeOfDay(hour: 7, minute: 30));
    }
    _loadSchedule();
  }

  Future<void> _loadSchedule() async {
    final data = await _logic.loadSchedule(
      userId: _userId,
      type: widget.type.name,
    );
    if (data.isNotEmpty) {
      setState(() {
        scheduleTimes = data;
      });
    }
  }

  Future<void> _pickTime(String day) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: scheduleTimes[day]!,
    );
    if (picked != null) {
      setState(() {
        scheduleTimes[day] = picked;
      });

      await _logic.saveSchedule(
        userId: _userId,
        type: widget.type.name,
        times: scheduleTimes,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenTitle =
    widget.type == ScheduleType.sleep ? 'Bedtime Schedule' : 'Wake-up Schedule';

    return Scaffold(
      appBar: AppBar(title: Text(screenTitle)),
      body: ListView(
        children: scheduleTimes.entries.map((entry) {
          return ListTile(
            title: Text(entry.key),
            subtitle: Text(entry.value.format(context)),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _pickTime(entry.key),
            ),
          );
        }).toList(),
      ),
    );
  }
}
