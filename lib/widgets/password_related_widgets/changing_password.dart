import 'package:flutter/material.dart';
import 'package:flutter_projects_1/widgets/password_related_widgets/text_field.dart';
import 'package:flutter_projects_1/widgets/password_related_widgets/update_password_button.dart';
import 'package:flutter_projects_1/widgets/password_related_widgets/visibility_controller.dart';
import 'package:provider/provider.dart';

Widget buildPasswordChangeScreenUI(
    BuildContext context,
    bool isPrivate,
    VoidCallback onInfoSelected,
    VoidCallback onPrivacySelected,
    ) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(height: 20),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldWithTitle("Old Password","Enter password"),
          const SizedBox(height: 10),
          _buildFieldWithTitle("New Password","Enter password"),
          const SizedBox(height: 10),
          _buildFieldWithTitle("Confirm New Password","Enter password"),
          const SizedBox(height: 30),
        ],
      ),

      Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: SizedBox(
          child: UpdatePasswordButton(
            onPressed: () {
              print("Update Password Clicked");
            },
          ),
        ),
      ),
    ],
  );
}

Widget _buildFieldWithTitle(String title, String hintText) {
  return ChangeNotifierProvider(
    create: (_) => VisibilityController(),  // Each field gets its own visibility state
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        TextFieldPassword(hintText: hintText),
      ],
    ),
  );
}
