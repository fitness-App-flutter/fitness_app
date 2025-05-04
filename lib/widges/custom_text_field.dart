import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final Function(String)? onchange;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    this.onchange,
    required this.hintText,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onchange,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
