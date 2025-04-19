// widgets/OverviewWidgets/header_section.dart

import 'package:flutter/material.dart';
import '../../models/date_utils.dart'; // Import date utilities

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  // Function to check if it's daytime (6 AM to 6 PM)
  bool _isDaytime() {
    final now = DateTime.now();
    final hour = now.hour;
    return hour >= 6 && hour < 18; // Daytime is between 6 AM and 6 PM
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Side: Icon and Date
          Row(
            children: [
              Icon(
                _isDaytime() ? Icons.wb_sunny : Icons.nightlight_round, // Sun or Moon icon
                color: Color(0xff7168EB),
              ),
              const SizedBox(width: 8), // Space between icon and text
              Text(
                getFormattedDate(), // Dynamic date
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // Right Side: User Avatar
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey[300],
            backgroundImage: AssetImage('assets/images/profile.jpg')
          ),
        ],
      ),
    );
  }
}