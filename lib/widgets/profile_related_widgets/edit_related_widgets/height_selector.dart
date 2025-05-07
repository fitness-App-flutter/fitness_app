import 'package:fitness_app/core/utils/color_extension.dart';
import 'package:flutter/material.dart';

class HeightSelector extends StatelessWidget {
  final int? value;
  final int? min;
  final int? max;
  final ValueChanged<int>? onChanged;

  final int? height;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;

  const HeightSelector({
    super.key,
    this.value,
    this.min,
    this.max,
    this.onChanged,
    this.height,
    this.onIncrease,
    this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    final currentHeight = value ?? height ?? 0;

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
                  onPressed: onDecrease ??
                      (onChanged != null && min != null && currentHeight > min!
                          ? () => onChanged!(currentHeight - 1)
                          : null),
                  icon: const Icon(Icons.remove, color: Colors.grey),
                ),
              ),
              Text(
                currentHeight.toString(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Card(
                color: MyColors.blue_register,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: IconButton(
                  onPressed: onIncrease ??
                      (onChanged != null && max != null && currentHeight < max!
                          ? () => onChanged!(currentHeight + 1)
                          : null),
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
