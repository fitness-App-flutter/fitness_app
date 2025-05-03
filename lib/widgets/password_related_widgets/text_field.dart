import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'visibility_controller.dart';

class TextFieldPassword extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller; // Added controller parameter

  const TextFieldPassword({
    super.key,
    required this.hintText,
    this.controller, // Make it optional to maintain backward compatibility
  });

  @override
  Widget build(BuildContext context) {
    final visibilityController = Provider.of<VisibilityController>(context);

    return TextField(
      controller: controller, // Added controller here
      obscureText: !visibilityController.isVisible,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: const Color(0xffF3F4F6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            visibilityController.isVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: const Color(0xff565e6c),
          ),
          onPressed: visibilityController.toggleVisibility,
        ),
      ),
      style: const TextStyle(color: Color(0xff565e6c)),
    );
  }
}