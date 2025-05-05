import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class StepCounterLogic extends ChangeNotifier {
  int steps = 0;
  double _previousMagnitude = 0.0;

  double _calculateMagnitude(double x, double y, double z) {
    return sqrt(x * x + y * y + z * z);
  }

  void updateSteps(AccelerometerEvent event) {
    final currentMagnitude = _calculateMagnitude(event.x, event.y, event.z);
    final difference = (currentMagnitude - _previousMagnitude).abs();

    if (difference > 7) {
      steps++;
      _saveStepsToFirestore(steps);
      notifyListeners();
    }

    _previousMagnitude = currentMagnitude;
  }

  Future<void> _saveStepsToFirestore(int steps) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final timestamp = Timestamp.now();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set({
        'steps': steps,
        'timestamp': timestamp,
      }, SetOptions(merge: true));
    }
  }


  Future<void> loadInitialData() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        steps = userDoc.data()?['steps'] ?? 0;
      }
    }
    notifyListeners();
  }
}
