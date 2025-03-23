import 'package:flutter/material.dart';
import 'package:test_app/widgets/colors.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const ScreenTitle({
    Key? key,
    required this.title,
    this.icon = Icons.waving_hand, // Default waving hand emoji
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        Icon(icon, color: MyColors.orange),
      ],
    );
  }
}
