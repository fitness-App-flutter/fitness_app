import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/widgets/SleepWidgets/sleep_chart.dart';
import 'package:fitness_app/widgets/SleepWidgets/sleep_header.dart';
import 'package:fitness_app/widgets/SleepWidgets/sleep_schedule.dart';
import 'package:fitness_app/widgets/SleepWidgets/sleep_statistics.dart';
import 'package:flutter/material.dart';

class SleepPage extends StatefulWidget {
  const SleepPage({super.key});

  @override
  State<SleepPage> createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  Map<String, TimeOfDay> sleepTimes = {};
  Map<String, TimeOfDay> wakeTimes = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSleepData();
  }

  Future<void> loadSleepData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (doc.exists) {
      final data = doc.data();
      final Map<String, dynamic> sleep = data?['sleepTimes'] ?? {};
      final Map<String, dynamic> wake = data?['wakeTimes'] ?? {};

      setState(() {
        sleepTimes = sleep.map((key, value) {
          final timeParts = value.split(":");
          return MapEntry(
              key,
              TimeOfDay(
                  hour: int.parse(timeParts[0]),
                  minute: int.parse(timeParts[1])));
        });

        wakeTimes = wake.map((key, value) {
          final timeParts = value.split(":");
          return MapEntry(
              key,
              TimeOfDay(
                  hour: int.parse(timeParts[0]),
                  minute: int.parse(timeParts[1])));
        });

        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            :const Padding(
                padding:  EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     SleepHeader(),
                     SizedBox(height: 20),
                     SleepChart(),
                     SizedBox(height: 20),
                     SleepStatistics(),
                     SizedBox(height: 20),
                    SleepSchedule(),
                  ],
                ),
              ),
      ),
    );
  }
}
