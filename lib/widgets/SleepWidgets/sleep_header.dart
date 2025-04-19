import 'package:flutter/material.dart';

class SleepHeader extends StatelessWidget {
  const SleepHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center( // Center the content horizontally
      child: Column(
        mainAxisSize: MainAxisSize.min, // Minimize the height of the Column
        children: [
          const Text(
            "Sleep",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 8),
          RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold ,color: Colors.black),
              children: [
                TextSpan(text: "Your average time of\n"),
                TextSpan(
                  text: "sleep a day is ",
                ),
                TextSpan(
                  text: "7h 31 min",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ],
            ),
            textAlign: TextAlign.center, // Center-align the text
          ),
        ],
      ),
    );
  }
}