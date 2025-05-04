import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_app/widgets/password_related_widgets/text_field.dart';
import 'package:fitness_app/widgets/password_related_widgets/update_password_button.dart';
import 'package:fitness_app/widgets/password_related_widgets/visibility_controller.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/widgets/password_related_widgets/password_service.dart';

Widget buildPasswordChangeScreenUI(
    BuildContext context,
    bool isPrivate,
    VoidCallback onInfoSelected,
    VoidCallback onPrivacySelected,
    ) {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> _updatePassword() async {
    final message = await PasswordService.changePassword(
      currentPassword: oldPasswordController.text,
      newPassword: newPasswordController.text,
      confirmPassword: confirmPasswordController.text,
    );

    if (message == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully!')),
      );
      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }


  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(height: 20),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldWithTitle("Current Password", "Enter current password", oldPasswordController),
          const SizedBox(height: 10),
          _buildFieldWithTitle("New Password", "Enter new password", newPasswordController),
          const SizedBox(height: 10),
          _buildFieldWithTitle("Confirm Password", "Re-enter new password", confirmPasswordController),
          const SizedBox(height: 30),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: UpdatePasswordButton(onPressed: _updatePassword),
      ),
    ],
  );
}

Widget _buildFieldWithTitle(String title, String hintText, TextEditingController controller) {
  return ChangeNotifierProvider(
    create: (_) => VisibilityController(),
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
        TextFieldPassword(
          hintText: hintText,
          controller: controller,
        ),
      ],
    ),
  );
}