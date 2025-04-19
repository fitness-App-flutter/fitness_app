import 'package:flutter/material.dart';

class SleepStatistics extends StatelessWidget {
  const SleepStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatCard("🌞 Sleep rate", "82%"),
        _buildStatCard("😴 Deep sleep", "1h 3min"),
      ],
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
