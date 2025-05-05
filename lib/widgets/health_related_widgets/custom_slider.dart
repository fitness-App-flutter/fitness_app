import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'custom_slider_thumb.dart';

class CustomSlider extends StatelessWidget {
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;
  final Color color;
  final Color tooltipColor;
  final String Function(int)? tooltipFormatter;

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
        min: min.toDouble(),
        max: max.toDouble(),
        value: value.toDouble(),
        showTicks: false,
        showLabels: false,
        enableTooltip: true,
        activeColor: color,
        inactiveColor: color.withOpacity(0.3),
        tooltipTextFormatterCallback: (dynamic val, String formattedText) {
          return tooltipFormatter != null ? tooltipFormatter!(val.toInt()) : "${val.toInt()}";
        },
        thumbIcon: CustomSliderThumb(
          thumbRadius: 12,
          borderColor: color,
        ),
        onChanged: (dynamic newValue) {
          onChanged((newValue as double).round());
        },
      ),
    );
  }
}
