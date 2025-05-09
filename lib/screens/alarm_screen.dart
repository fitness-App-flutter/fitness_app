import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key, required this.title});
  final String title;

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  Map<String, TimeOfDay> alarmTimes = {
    'Monday': const TimeOfDay(hour: 7, minute: 0),
    'Tuesday': const TimeOfDay(hour: 7, minute: 0),
    'Wednesday': const TimeOfDay(hour: 7, minute: 0),
    'Thursday': const TimeOfDay(hour: 7, minute: 0),
    'Friday': const TimeOfDay(hour: 7, minute: 0),
    'Saturday': const TimeOfDay(hour: 7, minute: 0),
    'Sunday': const TimeOfDay(hour: 7, minute: 0),
  };

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    _initNotifications();
  }

  Future<void> _initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
  }

  Future<void> scheduleAlarm(TimeOfDay time, String dayName) async {
    final now = DateTime.now();
    final daysMap = {
      'Monday': DateTime.monday,
      'Tuesday': DateTime.tuesday,
      'Wednesday': DateTime.wednesday,
      'Thursday': DateTime.thursday,
      'Friday': DateTime.friday,
      'Saturday': DateTime.saturday,
      'Sunday': DateTime.sunday,
    };

    final int day = daysMap[dayName]!; // get corresponding day number
    DateTime scheduledDate = DateTime(now.year, now.month, now.day, time.hour, time.minute);

    // Adjust to the correct day, making sure the scheduled time is in the future
    while (scheduledDate.weekday != day || scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    // Ensure using timezone with correct TZDateTime for Cairo timezone
    final tz.TZDateTime scheduledTZDateTime = tz.TZDateTime.from(scheduledDate, tz.getLocation('Africa/Cairo'));

    await flutterLocalNotificationsPlugin.zonedSchedule(
      day, // use weekday as ID
      '⏰ Alarm',
      'Time to ${widget.title.toLowerCase()}!',
      scheduledTZDateTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'alarm_channel',
          'Alarms',
          channelDescription: 'Alarm notifications',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('alarm'),
        ),
      ),
      androidAllowWhileIdle: true, // allow alarm while the phone is idle
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> _pickTime(String day) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: alarmTimes[day]!,
    );
    if (picked != null) {
      setState(() {
        alarmTimes[day] = picked;
      });
      await scheduleAlarm(picked, day);
    }
  }@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.title} Alarms')),
      body: ListView(
        children: alarmTimes.entries.map((entry) {
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