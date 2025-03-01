import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart'; // For SfSlider
import 'package:syncfusion_flutter_core/theme.dart'; // For SfSliderTheme
import 'custom_slider_thumb.dart'; // Import CustomSliderThumb

class NutrientSliderRow extends StatelessWidget {
  final String nutrient;
  final double value;
  final ValueChanged<double> onChanged;
  final Color color;
  final Color tooltipColor;

  const NutrientSliderRow({
    super.key,
    required this.nutrient,
    required this.value,
    required this.onChanged,
    required this.color,
    required this.tooltipColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // Align items vertically
        children: [
          // Left Column: Category Circle & Label
          SizedBox(
            width: 120, // Fixed width for the category section
            child: Row(
              children: [
                CircleAvatar(radius: 12, backgroundColor: color),
                const SizedBox(width: 8),
                Text(
                  nutrient,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16), // Spacing between category and slider

          // Slider + Dynamic Gram Display
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Slider
                    SfSliderTheme(
                      data: SfSliderThemeData(
                        tooltipBackgroundColor: tooltipColor,
                      ),
                      child: SfSlider(
                        min: 0.0,
                        max: 1000.0,
                        value: value,
                        showTicks: false,
                        showLabels: false,
                        enableTooltip: true,
                        activeColor: color,
                        inactiveColor: color.withOpacity(0.3),
                        tooltipTextFormatterCallback: (dynamic value, String formattedText) {
                          return "${value.toInt()}g";
                        },
                        thumbIcon: CustomSliderThumb(
                          thumbRadius: 12,
                          borderColor: color,
                        ),
                        onChanged: (dynamic newValue) {
                          onChanged(newValue);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}