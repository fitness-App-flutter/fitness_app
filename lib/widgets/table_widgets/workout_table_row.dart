import 'package:flutter/material.dart';
import 'package:fitness_app/core/utils/color_extension.dart';
class WorkoutTableRow extends TableRow {
  WorkoutTableRow({
    required String exercise,
    required List<String> muscles,
    required String percentage,
    required Color percentageColor,
  }) : super(
    children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise,
              style: TextStyle(fontWeight: FontWeight.bold, color: MyColors.table_purple),
            ),
            for (var muscle in muscles)
              Text(
                muscle,
                style: const TextStyle(fontSize: 12),
              ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          percentage,
          style: TextStyle(color: percentageColor, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}
