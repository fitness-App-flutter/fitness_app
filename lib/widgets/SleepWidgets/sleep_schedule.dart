import 'package:fitness_app/screens/schedule_screen.dart';
import 'package:flutter/material.dart';

class SleepSchedule extends StatelessWidget {
  const SleepSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Set your schedule",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildScheduleCard(
              context,
              "🛏 Bedtime",
              const Color(0xffea926e),
              ScheduleType.sleep,
            ),
            _buildScheduleCard(
              context,
              "🔔 Wake up",
              const Color(0xff7F55E0),
              ScheduleType.wake,
            ),
          ],
        ),
      ],
    );
  }

  static Widget _buildScheduleCard(
      BuildContext context,
      String title,
      Color color,
      ScheduleType type,
      ) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScheduleScreen(
                        title: title,
                        type: type,
                      ),
                    ),
                  );
                },
                child: const Icon(
                  Icons.edit,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
