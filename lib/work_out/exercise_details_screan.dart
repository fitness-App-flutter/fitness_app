import 'package:fitness_app/core/utils/color_extension.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // استيراد مكتبة async للتعامل مع المؤقت

class ExerciseDetailScreen extends StatefulWidget { // تغيير StatelessWidget إلى StatefulWidget
  final String name;
  final String reps;
  final String imageUrl;

  const ExerciseDetailScreen({
    Key? key,
    required this.name,
    required this.reps,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _ExerciseDetailScreenState createState() => _ExerciseDetailScreenState(); // إنشاء الـ State
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  int _secondsRemaining = 30; // المدة الابتدائية للعد التنازلي (يمكن تغييرها)
  bool _isRunning = false;
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel(); // إلغاء المؤقت عند الخروج من الشاشة
    super.dispose();
  }

  void _startTimer() {
    if (!_isRunning) {
      _isRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_secondsRemaining > 0) {
            _secondsRemaining--;
          } else {
            _timer.cancel();
            _isRunning = false;
            // يمكنك إضافة إجراء هنا عند انتهاء المؤقت، مثل عرض رسالة
          }
        });
      });
    }
  }

  void _resetTimer() {
    setState(() {
      _secondsRemaining = 30; // إعادة تعيين الوقت
      _isRunning = false;
      _timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: MyColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Image.asset(widget.imageUrl, height: 250, fit: BoxFit.cover),
            const SizedBox(height: 24),
            Text(widget.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(widget.reps, style: const TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '🔥 Tip: Maintain your posture and focus on the performance 👌\nKeep going and develop yourself with every exercise!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Time remaining: $_secondsRemaining seconds',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _startTimer,
                  child: Text(_isRunning ? 'stop' : 'start'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}