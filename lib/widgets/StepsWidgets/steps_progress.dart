import 'package:flutter/material.dart';

class StepsProgress extends StatelessWidget {
  const StepsProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCircularChart(13857, 18000),
      ],
    );
  }

  Widget _buildCircularChart(int steps, int goal) {
    double progress = steps / goal;
    return SizedBox(
      width: 160,
      height: 120,
      child: CustomPaint(
        painter: CircularChartPainter(progress),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.directions_walk, // Use any icon you prefer
                size: 30, // Adjust the size of the icon
                color:Color(0xFF636AE8), // Adjust the color of the icon
              ),
              const SizedBox(height: 8), // Add spacing between the icon and text
              Text(
                "$steps",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4), // Add spacing between the icon and text
              const Text(
                "Steps Out Of 18K",
                style: TextStyle(fontSize: 12,color: Colors.grey),
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
    final radius = size.width / 2 - 5;

    // Draw the background circle (with a gap at the bottom)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3.14159 * 0.75, // Start angle (top-left)
      3.14159 * 1.5, // Sweep angle (270 degrees, leaving a gap at the bottom)
      false,
      backgroundPaint,
    );

    // Draw the progress arc (with a gap at the bottom)
    final sweepAngle = 3.14159 * 1.5 * progress; // Progress based on 270 degrees
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3.14159 * 0.75, // Start angle (top-left)
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}