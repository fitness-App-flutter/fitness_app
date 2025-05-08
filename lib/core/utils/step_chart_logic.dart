import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StepChartLogic {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<double>> getStepData(String period) async {
    switch (period) {
      case 'Today':
        return await _getTodayStepData();
      case 'Weekly':
        return await _getWeeklyStepData();
      case 'Monthly':
        return await _getMonthlyStepData();
      default:
        return [];
    }
  }

  Future<List<double>> _getTodayStepData() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return List.filled(8, 0.0);

    final now = DateTime.now();
    final date = _formatDate(now);

    final hourlyCollection = _firestore
        .collection('users')
        .doc(userId)
        .collection('daily_steps')
        .doc(date)
        .collection('hourly');

    final snapshot = await hourlyCollection.get();

    List<double> periods = List.filled(8, 0.0);

    for (final doc in snapshot.docs) {
      final hourStr = doc.id;
      final hour = int.tryParse(hourStr);
      if (hour == null) continue;

      int periodIndex = _mapHourToPeriod(hour);
      periods[periodIndex] += (doc['steps'] as num?)?.toDouble() ?? 0.0;
    }

    return periods;
  }

  int _mapHourToPeriod(int hour) {
    if (hour >= 6 && hour < 9) return 0;
    if (hour >= 9 && hour < 12) return 1;
    if (hour >= 12 && hour < 15) return 2;
    if (hour >= 15 && hour < 18) return 3;
    if (hour >= 18 && hour < 21) return 4;
    if (hour >= 21 && hour < 24) return 5;
    if (hour >= 0 && hour < 3) return 6;
    if (hour >= 3 && hour < 6) return 7;
    return 0;
  }

  Future<List<double>> _getWeeklyStepData() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return List.filled(7, 0.0);

    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));

    List<double> weeklySteps = [];

    for (int i = 0; i < 7; i++) {
      final date = weekStart.add(Duration(days: i));
      final formattedDate = _formatDate(date);

      try {
        final doc = await _firestore
            .collection('users')
            .doc(userId)
            .collection('daily_steps')
            .doc(formattedDate)
            .get();

        weeklySteps.add((doc.data()?['steps'] as num?)?.toDouble() ?? 0.0);
      } catch (e) {
        weeklySteps.add(0.0);
      }
    }

    return weeklySteps;
  }

  Future<List<double>> _getMonthlyStepData() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return List.filled(4, 0.0);

    final now = DateTime.now();

    List<double> monthlySteps = List.filled(4, 0.0);

    try {
      final query = await _firestore
          .collection('users')
          .doc(userId)
          .collection('daily_steps')
          .where('date', isGreaterThanOrEqualTo: '${now.year}-${now.month.toString().padLeft(2, '0')}-01')
          .get();

      for (final doc in query.docs) {
        final date = doc['date'] as String;
        final day = int.parse(date.split('-')[2]);
        final weekIndex = (day - 1) ~/ 7;
        if (weekIndex < 4) {
          monthlySteps[weekIndex] += (doc['steps'] as num).toDouble();
        }
      }
    } catch (e) {
      print('Error fetching monthly data: $e');
    }

    return monthlySteps;
  }

  List<String> getChartLabels(String period) {
    switch (period) {
      case 'Today':
        return ['6AM', '9AM', '12PM', '3PM', '6PM', '9PM', '12AM', '3AM'];
      case 'Weekly':
        return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      case 'Monthly':
        return ['Week1', 'Week2', 'Week3', 'Week4'];
      default:
        return [];
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
