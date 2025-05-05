import 'dart:math';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class StepCounterLogic extends ChangeNotifier {
  int _stepsToday = 0;
  int _totalSteps = 0;
  double _previousMagnitude = 0.0;
  bool _isDataLoaded = false;
  bool _isAboveThreshold = false;
  StreamSubscription? _firestoreSubscription;
  StreamSubscription? _sensorSubscription;

  final List<double> _magnitudeBuffer = [];
  static const int _bufferSize = 3;
  static const double _stepThreshold = 5.0;
  static const double _resetThreshold = 3.0;

  int get stepsToday => _stepsToday;
  int get totalSteps => _totalSteps;
  bool get isDataLoaded => _isDataLoaded;

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
        _stepsToday = (dailyDoc.data()?['steps'] as num?)?.toInt() ?? 0;
      }

      final summaryDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('steps_history')
          .doc('summary')
          .get();

      if (summaryDoc.exists) {
        _totalSteps = (summaryDoc.data()?['totalSteps'] as num?)?.toInt() ?? 0;
      }

      _isDataLoaded = true;
      notifyListeners();
    } catch (e) {
      print('❌ خطأ في تحميل الخطوات: $e');
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
        if (newTotalSteps != _totalSteps) {
          _totalSteps = newTotalSteps;
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

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('daily_steps')
          .doc(today)
          .set({
        'steps': _stepsToday,
        'date': today,
        'lastUpdate': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('steps_history')
          .doc('summary')
          .set({
        'totalSteps': _totalSteps,
        'lastUpdate': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      print('✅ تم حفظ الخطوات - اليوم: $_stepsToday, الإجمالي: $_totalSteps');
    } catch (e) {
      print('❌ خطأ في حفظ الخطوات: $e');
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