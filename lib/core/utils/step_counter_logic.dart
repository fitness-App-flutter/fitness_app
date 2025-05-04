import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sensors_plus/sensors_plus.dart';

class StepCounterLogic {
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
    }

    _previousMagnitude = currentMagnitude;
  }

  Future<void> _saveStepsToFirestore(int steps) async {
    final userId = 'userId';
    final timestamp = Timestamp.now();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('steps')
        .add({
      'steps': steps,
      'timestamp': timestamp,
    });
  }

  Future<void> loadInitialData() async {
    steps = 0;
    _previousMagnitude = 0.0;
  }
}
