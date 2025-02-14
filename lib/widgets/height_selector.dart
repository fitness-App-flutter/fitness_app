import 'package:flutter/material.dart';

class HeightSelector extends StatelessWidget {
  final int height;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const HeightSelector({
    Key? key,
    required this.height,
    required this.onIncrease,
    required this.onDecrease,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Height (cm)"),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1), // Padding inside the border
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width:.5), // Border color & width
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onDecrease,
              icon: const Icon(Icons.remove),
            ),
            Text(height.toString(), style: const TextStyle(fontSize: 18)),
            IconButton(
              onPressed: onIncrease,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    ],
  );
}
}