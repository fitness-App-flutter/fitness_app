import 'package:flutter/material.dart';

class WorkoutTableCell extends StatelessWidget {
  final String? title;
  final List<String>? muscles;
  final String? percentage;
  final Color? percentageColor;

  const WorkoutTableCell({super.key, this.title, this.muscles, this.percentage, this.percentageColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: title != null
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(
                0xFF7B55CE), fontSize: 14),
          ),
          for (var muscle in muscles!)
            Text(
              muscle,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
        ],
      )
          : Text(
        percentage!,
        style: TextStyle(color: percentageColor, fontWeight: FontWeight.bold, fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }
}
