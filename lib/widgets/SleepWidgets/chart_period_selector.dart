import 'package:flutter/material.dart';

class ChartPeriodSelector extends StatelessWidget {
  final String selectedPeriod;
  final Function(String) onPeriodChanged;

  const ChartPeriodSelector({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: ["Today", "Weekly", "Monthly"].map((period) {
        bool isSelected = selectedPeriod == period;

        return InkWell(
          onTap: () => onPeriodChanged(period),
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xff878CED) : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              period,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black54,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
