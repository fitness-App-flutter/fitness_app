import 'package:flutter/material.dart';
import 'package:fitness_app/utils/color_extension.dart';
import 'workout_table_row.dart';

class TableBordersAndCorners extends StatelessWidget {
  const TableBordersAndCorners({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(2),
          },
          border: TableBorder(
            horizontalInside: BorderSide(color: Colors.grey.shade300, width: 1), // ✅ Horizontal dividers
            verticalInside: BorderSide(color: Colors.grey.shade300, width: 1),   // ✅ Vertical divider
          ),
          children: [
            // Table Header
            TableRow(
              decoration: BoxDecoration(color: Colors.grey.shade50),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Exercises',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Achieved',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            // Table Rows
            WorkoutTableRow(
              exercise: 'Bench Press',
              muscles: ['Chest', 'Shoulders', 'Triceps'],
              percentage: '65%',
              percentageColor: MyColors.table_orange,
            ),
            WorkoutTableRow(
              exercise: 'Leg Press',
              muscles: ['Quads', 'Hamstrings', 'Glutes'],
              percentage: '90%',
              percentageColor: MyColors.table_green,
            ),
          ],
        ),
      ),
    );
  }
}
