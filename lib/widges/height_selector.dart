import 'package:flutter/material.dart';

class HeightSelector extends StatelessWidget {
  final int height;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const HeightSelector({
    super.key,
    required this.height,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Height (cm)"),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          // Padding inside the border
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: .5),
            // Border color & width
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(height.toString(),
                  style: const TextStyle(fontSize: 18)),
              Card(
                color: Colors.grey[200],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: IconButton(
                  onPressed: onDecrease,
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.grey,
                  ),
                ),
              ),
              Card(
                color: const Color(0xff626ae7),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: IconButton(
                  onPressed: onIncrease,
                  icon: const Icon(
                    Icons.add,color: Colors.white, ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}