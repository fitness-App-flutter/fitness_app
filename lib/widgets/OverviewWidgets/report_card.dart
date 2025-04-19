import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;

  const ReportCard({super.key, required this.emoji, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 6, spreadRadius: 2),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                emoji,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
