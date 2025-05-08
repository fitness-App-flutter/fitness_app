import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StepsLineChart extends StatelessWidget {
  final String period;
  final List<double> stepData;
  final List<String> labels;

  const StepsLineChart({
    super.key,
    required this.period,
    required this.stepData,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        backgroundColor: const Color(0xff888CED),
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 && value.toInt() < labels.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      labels[value.toInt()],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: stepData.length > 0 ? stepData.length.toDouble() - 1 : 0,
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              stepData.length,
                  (index) => FlSpot(index.toDouble(), stepData[index]),
            ),
            isCurved: true,
            curveSmoothness: 0.3,
            color: Colors.white,
            barWidth: 2,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(show: false),
            dotData: const FlDotData(show: true),
          ),
        ],
      ),
    );
  }
}
