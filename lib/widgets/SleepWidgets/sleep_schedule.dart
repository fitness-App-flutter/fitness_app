import 'package:fitness_app/screens/alarm_page.dart';
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
              "22:00 pm",
              const Color(0xffea926e),
            ),
            _buildScheduleCard(
              context,
              "🔔 Wake up",
              "07:30 am",
              const Color(0xff7F55E0),
            ),
          ],
        ),
      ],
    );
  }

  static Widget _buildScheduleCard(
      BuildContext context,
      String title,
      String time,
      Color color,
      ) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AlarmPage()),
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
          const SizedBox(height: 5),
          Text(
            time,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

