import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AlarmService {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    await _initAudio();
    await _initNotifications();
  }

  static Future<void> _initAudio() async {
    await _audioPlayer.setAsset('assets/sounds/alarm.mp3');
  }

  static Future<void> _initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> setAlarm(DateTime time, int alarmId) async {
    await AndroidAlarmManager.oneShotAt(
      time,
      alarmId,
      _triggerAlarm,
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true,
      allowWhileIdle: true,
    );
  }

  static Future<void> _triggerAlarm() async {
    await _showNotification();
    await _playAlarmSound();
  }

  static Future<void> _playAlarmSound() async {
    try {
      await _audioPlayer.setVolume(1.0);
      await _audioPlayer.play();
      await _audioPlayer.setLoopMode(LoopMode.one);
      await Future.delayed(const Duration(minutes: 1));
    } catch (e) {
      print('Error playing alarm: $e');
    } finally {
      await _audioPlayer.stop();
    }
  }

  static Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'alarm_channel',
      'المنبهات',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('alarm'),
    );

    await _notificationsPlugin.show(
      0,
      'المنبه',
      'حان وقت المنبه!',
      const NotificationDetails(android: androidPlatformChannelSpecifics),
    );
  }

  static Future<void> cancelAlarm(int alarmId) async {
    await AndroidAlarmManager.cancel(alarmId);
  }

  static Future<void> testSound() async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.setAsset('assets/sounds/alarm.mp3');
      await _audioPlayer.setVolume(1.0);
      await _audioPlayer.play();
    } catch (e) {
      print('Error testing sound: $e');
      rethrow;
    }
  }

  static Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}