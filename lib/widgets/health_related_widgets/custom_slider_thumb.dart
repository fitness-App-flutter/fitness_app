import 'package:flutter/material.dart';
class CustomSliderThumb extends StatelessWidget {
  final double thumbRadius;
  final Color borderColor;

  const CustomSliderThumb({
    super.key,
    required this.thumbRadius,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: thumbRadius * 2,
      height: thumbRadius * 2,
      decoration: BoxDecoration(
        color: Colors.white, // Thumb fill color
        shape: BoxShape.circle, // Circular thumb
        border: Border.all(
          color: borderColor, // Border color
          width: 1.0, // Border width
        ),
      ),
    );
  }
}
