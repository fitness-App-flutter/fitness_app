import 'dart:math';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class StepCounterLogic extends ChangeNotifier {
  int _stepsToday = 0;
  int _totalSteps = 0;
  double _distanceToday = 0.0;
  double _totalDistance = 0.0;
  double _previousMagnitude = 0.0;
  bool _isDataLoaded = false;
  bool _isAboveThreshold = false;
  StreamSubscription? _firestoreSubscription;
  StreamSubscription? _sensorSubscription;

  final List<double> _magnitudeBuffer = [];
  static const int _bufferSize = 3;
  static const double _stepThreshold = 5.0;
  static const double _resetThreshold = 3.0;
  static const double _stepLength = 0.762;
  static const int _dailyStepGoal = 18000;
  static const double _dailyDistanceGoal = _dailyStepGoal * _stepLength;

  int get dailyStepGoal => _dailyStepGoal;

  int get stepsToday => _stepsToday;
  int get totalSteps => _totalSteps;
  double get distanceToday => _distanceToday;
  double get totalDistance => _totalDistance;
  double get distanceProgress => (_distanceToday / _dailyDistanceGoal).clamp(0.0, 1.0);
  double get stepProgress => (_stepsToday / _dailyStepGoal).clamp(0.0, 1.0);
  String get formattedDailyDistanceGoal => (_dailyDistanceGoal / 1000).toStringAsFixed(1);
  bool get isDataLoaded => _isDataLoaded;

  int get caloriesBurned => (_stepsToday * 0.04).round();
  int get walkingMinutes {
    return ((_stepsToday / _dailyStepGoal) * (_dailyStepGoal / 100)).round();
  }

  StepCounterLogic() {
    _initStepCounter();
  }

  double _calculateFilteredMagnitude(double x, double y, double z) {
    final magnitude = sqrt(x * x + y * y + z * z);
    _magnitudeBuffer.add(magnitude);
    if (_magnitudeBuffer.length > _bufferSize) {
      _magnitudeBuffer.removeAt(0);
    }
    return _magnitudeBuffer.reduce((a, b) => a + b) / _magnitudeBuffer.length;
  }

  Future<void> _initStepCounter() async {
    await loadInitialSteps();
    _setupFirestoreListener();
    _listenToAccelerometer();
  }

  Future<void> loadInitialSteps() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    try {
      final today = _getFormattedDate();

      final dailyDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('daily_steps')
          .doc(today)
          .get();

      if (dailyDoc.exists) {
        final data = dailyDoc.data();
        _stepsToday = (data?['steps'] as num?)?.toInt() ?? 0;
        _distanceToday = (data?['distance'] as num?)?.toDouble() ?? 0.0;
      }

      final summaryDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('steps_history')
          .doc('summary')
          .get();

      if (summaryDoc.exists) {
        final data = summaryDoc.data();
        _totalSteps = (data?['totalSteps'] as num?)?.toInt() ?? 0;
        _totalDistance = (data?['totalDistance'] as num?)?.toDouble() ?? 0.0;
      }

      _isDataLoaded = true;
      notifyListeners();
    } catch (e) {
      print('❌ خطأ في تحميل البيانات: $e');
      _isDataLoaded = true;
      notifyListeners();
    }
  }

  void _setupFirestoreListener() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    _firestoreSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('steps_history')
        .doc('summary')
        .snapshots()
        .listen((doc) {
      if (doc.exists) {
        final newTotalSteps = (doc.data()?['totalSteps'] as num?)?.toInt() ?? 0;
        final newTotalDistance = (doc.data()?['totalDistance'] as num?)?.toDouble() ?? 0.0;

        if (newTotalSteps != _totalSteps || newTotalDistance != _totalDistance) {
          _totalSteps = newTotalSteps;
          _totalDistance = newTotalDistance;
          notifyListeners();
        }
      }
    });
  }

  void _listenToAccelerometer() {
    _sensorSubscription?.cancel();
    _previousMagnitude = 0.0;
    _isAboveThreshold = false;

    _sensorSubscription = accelerometerEvents.listen((event) {
      final currentMagnitude = _calculateFilteredMagnitude(event.x, event.y, event.z);
      final difference = (currentMagnitude - _previousMagnitude).abs();

      if (difference > _stepThreshold && !_isAboveThreshold) {
        _isAboveThreshold = true;
        _stepsToday++;
        _totalSteps++;

        _distanceToday = _stepsToday * _stepLength;
        _totalDistance = _totalSteps * _stepLength;

        _saveStepsToFirestore();
        notifyListeners();
      } else if (difference < _resetThreshold) {
        _isAboveThreshold = false;
      }

      _previousMagnitude = currentMagnitude;
    });
  }

  Future<void> _saveStepsToFirestore() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final today = _getFormattedDate();
    final hour = DateTime.now().hour.toString();
    final calories = (_stepsToday * 0.04).round();
    final minutes = (_stepsToday / 100).round();

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('daily_steps')
          .doc(today)
          .collection('hourly') // نضيف مجموعة `hourly` لتخزين البيانات لكل ساعة
          .doc(hour)
          .set({
        'steps': _stepsToday,
        'distance': _distanceToday,
        'calories': calories,
        'walkingMinutes': minutes,
        'date': today,
        'hour': hour,
        'lastUpdate': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('steps_history')
          .doc('summary')
          .set({
        'totalSteps': _totalSteps,
        'totalDistance': _totalDistance,
        'lastUpdate': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      print('✅ تم حفظ البيانات - خطوات: $_stepsToday، مسافة: ${_distanceToday.toStringAsFixed(2)}m، سعرات: $calories، وقت: $minutes دقيقة');
    } catch (e) {
      print('❌ خطأ في حفظ البيانات: $e');
    }
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _firestoreSubscription?.cancel();
    _sensorSubscription?.cancel();
    _saveStepsToFirestore();
    super.dispose();
  }
}
