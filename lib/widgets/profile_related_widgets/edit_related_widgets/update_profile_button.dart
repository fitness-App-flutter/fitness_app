import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/widgets/profile_related_widgets/profile_controller.dart';
import 'package:fitness_app/core/helper/snack_bar.dart';
import 'package:fitness_app/utils/color_extension.dart';

class UpdateProfileButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const UpdateProfileButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () async {
        final controller = Provider.of<ProfileController>(context, listen: false);

        final String name = controller.nameController.text.trim();
        final String email = controller.emailController.text.trim();
        final int? weight = int.tryParse(controller.weightController.text.trim());
        final int? height = int.tryParse(controller.heightController.text.trim());


        if (name.isNotEmpty && weight != null && height != null) {
          await controller.updateProfile(
            name: name,
            email: email,
            weight: weight,
            height: height,
          );

          // Show success dialog
          ShowDialog(context, 'Profile updated successfully!');

          // Delay to show the dialog before navigating
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pop(); // Close dialog

            // Navigate to profile screen by route name
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/profile', // Make sure this route is defined in MaterialApp
                  (route) => false,
            );
          });
        } else {
          showSnackBar(context, 'Please fill all fields correctly');
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        decoration: BoxDecoration(
          border: Border.all(color: MyColors.PrimaryBlue, width: 1),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Text(
          "Update",
          style: TextStyle(
            color: MyColors.PrimaryBlue,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
