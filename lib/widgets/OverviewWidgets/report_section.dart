import 'package:fitness_app/core/utils/water_logic.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'report_card.dart';

class ReportSection extends StatefulWidget {
  final int stepsCount;

  const ReportSection({super.key, required this.stepsCount});

  @override
  State<ReportSection> createState() => _ReportSectionState();
}

class _ReportSectionState extends State<ReportSection> {
  int waterCups = 16;
  late String userId;
  final WaterLogic _waterLogic = WaterLogic();

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
      loadWaterCups();
    } else {
      debugPrint("User not logged in");
    }
  }

  Future<void> loadWaterCups() async {
    final cups = await _waterLogic.getWaterCups(userId);
    setState(() {
      waterCups = cups ?? 16; 
    });

    if (cups == null) {
      await _waterLogic.updateWaterCups(userId, 16);
    }
  }

  Future<void> decreaseWaterCups() async {
    if (waterCups > 0) {
      final newCups = waterCups - 1;
      setState(() {
        waterCups = newCups;
      });
      await _waterLogic.updateWaterCups(userId, newCups);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double totalWidth = constraints.maxWidth - 32;
        double cardWidth = (totalWidth / 2) - 8;
        double aspectRatio = (cardWidth / 100).clamp(1.8, 3.0);

        final items = [
          ReportCard(emoji: "👣", value: widget.stepsCount.toString(), label: "Steps"),
          const ReportCard(emoji: "💪", value: "6h 45min", label: "Workout"),
          const ReportCard(emoji: "😴", value: "29h 17min", label: "Sleep"),
          ReportCard(emoji: "🍶", value: "$waterCups Cups", label: "Water"),
        ];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today report",
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
                itemCount: items.length,
                itemBuilder: (context, index) => items[index],
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: waterCups > 0 ? decreaseWaterCups : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: const Color(0xff7F54DF),
                  minimumSize: const Size(200,50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Drink water",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
