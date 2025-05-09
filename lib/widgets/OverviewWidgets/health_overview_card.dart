import 'package:flutter/material.dart';

class HealthOverviewCard extends StatelessWidget {
  const HealthOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xfff2f2fc),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            "Health ",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
           SizedBox(height: 8),
           Text(
            "Based on your overview health tracking, You're Doing Great. Keep Going!",
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
