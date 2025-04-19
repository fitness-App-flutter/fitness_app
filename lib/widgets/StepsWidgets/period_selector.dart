import 'package:flutter/material.dart';

class PeriodSelector extends StatelessWidget {
  final String selectedPeriod;
  final Function(String) onPeriodChanged;

  const PeriodSelector({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    List<String> periods = ["Today", "Weekly", "Monthly"];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xff636AE8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: periods.map((period) {
          bool isSelected = selectedPeriod == period;
          return GestureDetector(
            onTap: () => onPeriodChanged(period),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                period,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? const Color(0xff878CED) : Colors.black54,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}