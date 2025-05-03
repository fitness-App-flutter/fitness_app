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

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                color: Colors.grey[200],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: IconButton(
                  onPressed: onDecrease,
                  icon: const Icon(Icons.remove, color: Colors.grey),
                ),
              ),
              Text(
                height.toString(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Card(
                color: const Color(0xff626ae7),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: IconButton(
                  onPressed: onIncrease,
                  icon: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
