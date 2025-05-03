import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/widgets/password_related_widgets/text_field.dart';
import 'package:fitness_app/widgets/password_related_widgets/update_password_button.dart';
import 'package:fitness_app/widgets/password_related_widgets/visibility_controller.dart';
import 'package:provider/provider.dart';

Widget buildPasswordChangeScreenUI(
    BuildContext context,
    bool isPrivate,
    VoidCallback onInfoSelected,
    VoidCallback onPrivacySelected,
    ) {
  // Controllers for text fields
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> _updatePassword() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      // Validate passwords match
      if (newPasswordController.text != confirmPasswordController.text) {
        throw Exception('New passwords do not match');
      }

      // Re-authenticate user
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPasswordController.text,
      );
      await user.reauthenticateWithCredential(credential);

      // Update password
      await user.updatePassword(newPasswordController.text);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully!')),
      );

      // Clear fields
      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();

    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'wrong-password':
          errorMessage = 'Incorrect old password';
          break;
        case 'weak-password':
          errorMessage = 'Password is too weak';
          break;
        default:
          errorMessage = 'Error updating password: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(height: 20),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldWithTitle("Old Password", "Enter password", oldPasswordController),
          const SizedBox(height: 10),
          _buildFieldWithTitle("New Password", "Enter password", newPasswordController),
          const SizedBox(height: 10),
          _buildFieldWithTitle("Confirm New Password", "Enter password", confirmPasswordController),
          const SizedBox(height: 30),
        ],
      ),

      Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: SizedBox(
          child: UpdatePasswordButton(
            onPressed: _updatePassword,
          ),
        ),
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