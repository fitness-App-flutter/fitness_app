import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../services/alarm_service.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  TimeOfDay selectedTime = TimeOfDay.now();
  List<Map<String, dynamic>> alarms = [];

  @override
  void initState() {
    super.initState();
    _initNotifications();
    _loadAlarms();
    _createNotificationChannel();
  }

  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'alarm_channel',
      'Alarm Notifications',
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound('alarm'),
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> _initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _loadAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final alarmStrings = prefs.getStringList('alarms') ?? [];
    setState(() {
      alarms = alarmStrings.map((str) {
        final parts = str.split('|');
        return {
          'id': int.parse(parts[0]),
          'time': DateTime.parse(parts[1]),
          'isActive': parts[2] == 'true',
        };
      }).toList();
    });
  }

  Future<void> _saveAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'alarms',
      alarms.map((alarm) => '${alarm['id']}|${alarm['time'].toIso8601String()}|${alarm['isActive']}').toList(),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Future<void> _addAlarm() async {
    bool hasPermission = true;


    if (!hasPermission) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please grant alarm permission')),
        );
      }
      return;
    }

    final now = DateTime.now();
    final alarmTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    final scheduledTime = alarmTime.isBefore(now)
        ? alarmTime.add(const Duration(days: 1))
        : alarmTime;

    final alarmId = scheduledTime.millisecondsSinceEpoch ~/ 1000;

    await AlarmService.setAlarm(scheduledTime, alarmId);

    setState(() {
      alarms.add({
        'id': alarmId,
        'time': scheduledTime,
        'isActive': true,
      });
    });

    await _saveAlarms();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Alarm set for ${selectedTime.format(context)}')),
      );
    }
  }

  Future<void> _testAlarmSound() async {
    try {
      await AlarmService.testSound();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Playing test sound...')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error playing sound: $e')),
        );
      }
    }
  }

  Future<void> _cancelAlarm(int id) async {
    await AlarmService.cancelAlarm(id);
    setState(() {
      alarms.removeWhere((alarm) => alarm['id'] == id);
    });
    await _saveAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alarm"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _testAlarmSound,
            child: const Text(
              'Test Alarm Sound',
              style: TextStyle(fontSize: 20),
            ),
          ),
          ElevatedButton(
            onPressed: () => _selectTime(context),
            child: Text(
              'Selected Time: ${selectedTime.format(context)}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          ElevatedButton(
            onPressed: _addAlarm,
            child: const Text(
              'Set Alarm',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: alarms.length,
              itemBuilder: (context, index) {
                final alarm = alarms[index];
                return ListTile(
                  title: Text(
                    'Alarm at ${TimeOfDay.fromDateTime(alarm['time']).format(context)}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _cancelAlarm(alarm['id']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}