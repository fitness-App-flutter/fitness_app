import 'package:flutter/material.dart';

class SleepSchedule extends StatelessWidget {
  const SleepSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text(
              "Set your schedule",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildScheduleCard("🛏 Bedtime", "22:00 pm", Color(0xffea926e)), // Bed icon
            _buildScheduleCard("🔔 Wake up", "07:30 am", Color(0xff7F55E0)), // Bell icon
          ],
        ),
      ],
    );
  }

  Widget _buildScheduleCard(String title, String time, Color color) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(
            time,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}