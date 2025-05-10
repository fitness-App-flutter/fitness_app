import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScheduleLogic {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveSchedule({
    required String userId,
    required String type,
    required Map<String, TimeOfDay> times,
  }) async {
    try {
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
    } catch (e) {
      throw Exception('Failed to save schedule: $e');
    }
  }

  Future<void> saveSleepData({
    required String userId,
    required Map<String, TimeOfDay> sleepTimes,
    required Map<String, TimeOfDay> wakeTimes,
    required Map<String, double> sleepDurations,
  }) async {
    try {
      final batch = _firestore.batch();
      final schedulesRef = _firestore.collection('users').doc(userId).collection('schedules');

      // Save sleep times
      batch.set(
        schedulesRef.doc('sleep'),
        {for (var e in sleepTimes.entries) e.key: _formatTime(e.value)},
      );

      // Save wake times
      batch.set(
        schedulesRef.doc('wake'),
        {for (var e in wakeTimes.entries) e.key: _formatTime(e.value)},
      );

      // Save durations
      batch.set(
        schedulesRef.doc('durations'),
        sleepDurations,
      );

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to save sleep data: $e');
    }
  }

  Future<Map<String, TimeOfDay>> loadSchedule({
    required String userId,
    required String type,
  }) async {
    try {
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
          entry.key: _parseTime(entry.value.toString()),
      };
    } catch (e) {
      throw Exception('Failed to load schedule: $e');
    }
  }

  Future<Map<String, double>> loadSleepDurations({
    required String userId,
  }) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('schedules')
          .doc('durations')
          .get();

      if (!doc.exists) return {};

      final data = doc.data() as Map<String, dynamic>;
      return {
        for (var entry in data.entries)
          entry.key: entry.value.toDouble(),
      };
    } catch (e) {
      throw Exception('Failed to load sleep durations: $e');
    }
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  TimeOfDay _parseTime(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }
}
