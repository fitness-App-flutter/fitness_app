import 'package:flutter/material.dart';
import 'package:fitness_app/core/utils/color_extension.dart';

class ProfileToggleButtons extends StatelessWidget {
  final bool isPrivate;
  final VoidCallback onInfoSelected;
  final VoidCallback onPrivacySelected;

  const ProfileToggleButtons({
    super.key,
    required this.isPrivate,
    required this.onInfoSelected,
    required this.onPrivacySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140, // Exact width from image
      height: 45, // Adjusted height to match the image
      decoration: BoxDecoration(
        color: Colors.grey.shade300, // Gray background
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          // Active Indicator (White Background)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            left: isPrivate ? 70 : 0, // Moves based on selection
            child: Container(
              width: 70, // Half of the toggle width
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: MyColors.PrimaryBlue, width: 2),
              ),
            ),
          ),
          // Button Row (Texts)
          Row(
            children: [
              _buildToggleText("Info.", !isPrivate, onInfoSelected),
              _buildToggleText("Priv.", isPrivate, onPrivacySelected),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleText(String text, bool isSelected, VoidCallback onPressed) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 45,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isSelected ? MyColors.PrimaryBlue : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
