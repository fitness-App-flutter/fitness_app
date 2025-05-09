import 'package:flutter/material.dart';
class ExerciseItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color bgColor;

  ExerciseItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.bgColor,
  });
}