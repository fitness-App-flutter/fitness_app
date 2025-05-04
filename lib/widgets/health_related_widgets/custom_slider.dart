import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'custom_slider_thumb.dart';

class CustomSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final Color color;
  final Color tooltipColor;
  final String Function(double)? tooltipFormatter;

  const CustomSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.color,
    required this.tooltipColor,
    this.tooltipFormatter,
  });

  @override
  Widget build(BuildContext context) {
    return SfSliderTheme(
      data: SfSliderThemeData(
        tooltipBackgroundColor: tooltipColor,
      ),
      child: SfSlider(
        min: min,
        max: max,
        value: value,
        showTicks: false,
        showLabels: false,
        enableTooltip: true,
        activeColor: color,
        inactiveColor: color.withOpacity(0.3),
        tooltipTextFormatterCallback: (dynamic value, String formattedText) {
          return tooltipFormatter != null ? tooltipFormatter!(value.toDouble()) : "${value.toInt()}";
        },
        thumbIcon: CustomSliderThumb(
          thumbRadius: 12,
          borderColor: color,
        ),
        onChanged: (dynamic newValue) {
          onChanged(newValue);
        },
      ),
    );
  }
}