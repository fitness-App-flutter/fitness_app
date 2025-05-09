import 'package:flutter/material.dart';
import 'table_borders_and_corners.dart';

class WorkoutTable extends StatelessWidget {
  const WorkoutTable({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Workout Exercises Title
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Workout Exercises",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),

          // Table with Rounded Corners & Borders
           TableBordersAndCorners(),
        ],
      ),
    );
  }
}

// ✅ Extracted TableBordersAndCorners widget

