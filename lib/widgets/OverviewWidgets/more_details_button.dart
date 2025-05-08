import 'package:fitness_app/screens/sleep_page.dart';
import 'package:flutter/material.dart';

class MoreDetailsButton extends StatelessWidget {
  const MoreDetailsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff7f54df),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SleepPage()),
          );
        },
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Sleep",
              style: TextStyle(fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            SizedBox(width: 64),
            Row(
              children: [
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff9770e8),
                  size: 24,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xffb491f8),
                  size: 24,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xffe1c9ff),
                  size: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
