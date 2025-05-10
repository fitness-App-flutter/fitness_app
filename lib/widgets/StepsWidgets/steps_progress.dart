import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> showGoalNotification() async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'goal_channel',
    'Goal Notifications',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    '🎉 Congratulations!',
    'You have reached your steps goal!',
    notificationDetails,
  );
}

class StepsProgress extends StatefulWidget {
  final int steps;
  final int goal;

  const StepsProgress({
    super.key,
    required this.steps,
    this.goal = 18000,
  });

  @override
  State<StepsProgress> createState() => _StepsProgressState();
}

class _StepsProgressState extends State<StepsProgress> {
  bool hasNotified = false;

  @override
  void didUpdateWidget(covariant StepsProgress oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!hasNotified && widget.steps >= widget.goal) {
      hasNotified = true;
      showGoalNotification();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildCircularChart(widget.steps, widget.goal);
  }

  Widget _buildCircularChart(int steps, int goal) {
    final int displayedSteps = steps;
    double progress = (displayedSteps / goal).clamp(0.0, 1.0);

    return SizedBox(
      width: 200,
      height: 200,
      child: CustomPaint(
        painter: CircularChartPainter(progress),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.directions_walk,
                size: 30,
                color:  Color(0xFF636AE8),
              ),
              const SizedBox(height: 8),
              Text(
                "$displayedSteps",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Goal: $goal",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CircularChartPainter extends CustomPainter {
  final double progress;

  CircularChartPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint progressPaint = Paint()
      ..color = const Color(0xFF636AE8)
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 15;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3.14159 * 0.75,
      3.14159 * 1.5,
      false,
      backgroundPaint,
    );

    final sweepAngle = 3.14159 * 1.5 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3.14159 * 0.75,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
