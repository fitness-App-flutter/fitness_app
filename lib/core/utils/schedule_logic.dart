import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScheduleLogic {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveSchedule({
    required String userId,
    required String type, // 'sleep' أو 'wake'
    required Map<String, TimeOfDay> times,
  }) async {
    final formattedTimes = {
      for (var entry in times.entries)
        entry.key: _formatTime(entry.value),
    };

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('schedules')
        .doc(type)
        .set(formattedTimes);
  }

  Future<void> saveSleepDurations({
    required String userId,
    required Map<String, double> sleepDurations,
  }) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('schedules')
        .doc('sleep_durations')
        .set(sleepDurations);
  }

  Future<Map<String, TimeOfDay>> loadSchedule({
    required String userId,
    required String type,
  }) async {
    final doc = await _firestore
        .collection('users')
        .doc(userId)
        .collection('schedules')
        .doc(type)
        .get();

    if (!doc.exists) return {};

    final data = doc.data() as Map<String, dynamic>;
    return {
      for (var entry in data.entries)
        entry.key: _parseTime(entry.value),
    };
  }

  Future<Map<String, double>> loadSleepDurations({
    required String userId,
  }) async {
    final doc = await _firestore
        .collection('users')
        .doc(userId)
        .collection('schedules')
        .doc('sleep_durations')
        .get();

    if (!doc.exists) return {};

    final data = doc.data() as Map<String, dynamic>;
    return {
      for (var entry in data.entries)
        entry.key: entry.value.toDouble(),
    };
  }

  String _formatTime(TimeOfDay time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  TimeOfDay _parseTime(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }
}
