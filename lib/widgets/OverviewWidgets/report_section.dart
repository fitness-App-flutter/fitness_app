import 'package:flutter/material.dart';
import 'report_card.dart';

class ReportSection extends StatelessWidget {
  const ReportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double totalWidth = constraints.maxWidth - 32;
        double cardWidth = (totalWidth / 2) - 8;
        double aspectRatio = (cardWidth / 100).clamp(1.8, 3.0);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "This week report",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: aspectRatio,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  const items = [
                    ReportCard(emoji: "👣", value: "697,978", label: "Steps"),
                    ReportCard(emoji: "💪", value: "6h 45min", label: "Workout"),
                    ReportCard(emoji: "❤️", value: "108 bpm/day", label: "Health"),
                    ReportCard(emoji: "😴", value: "29h 17min", label: "Sleep")
                  ];
                  return items[index];
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
