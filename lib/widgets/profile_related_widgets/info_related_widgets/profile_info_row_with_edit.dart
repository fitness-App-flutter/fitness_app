import 'package:flutter/material.dart';
import 'package:fitness_app/utils/color_extension.dart';
import 'package:fitness_app/widgets/profile_related_widgets/edit_profile_button.dart';

class ProfileInfoRowWithEdit extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onEditPressed;

  const ProfileInfoRowWithEdit({
    super.key,
    required this.label,
    required this.value,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0), // Left padding for label and value
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(fontSize: 16, color: MyColors.PrimaryBlue)),
                  const SizedBox(width: 8),
                  Text(value, style: TextStyle(fontSize: 16, color: MyColors.black)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24.0), // Add right padding to shift the button left
            child: EditProfileButton(onPressed: onEditPressed),
          ),
        ],
      ),
    );
  }
}