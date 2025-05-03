import 'package:flutter/material.dart';
import 'package:fitness_app/utils/color_extension.dart';

class UpdatePasswordButton extends StatelessWidget {
  final VoidCallback? onPressed; // ✅ Allows custom functionality

  const UpdatePasswordButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.PrimaryBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      ),
      child: const Text(
        "Update Password",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
