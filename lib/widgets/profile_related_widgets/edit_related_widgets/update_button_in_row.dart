import 'package:flutter/material.dart';
import 'package:flutter_projects_1/widgets/profile_related_widgets/edit_related_widgets/update_profile_button.dart';

class ProfileInfoRowWithUpdate extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final VoidCallback onUpdatePressed;

  const ProfileInfoRowWithUpdate({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.onUpdatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                hintText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 100,
            child: UpdateProfileButton(onPressed: onUpdatePressed),
          ),
        ],
      ),
    );
  }
}
