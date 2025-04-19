import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StepsLineChart extends StatelessWidget {
  final String period;

  const StepsLineChart({super.key, required this.period});

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
                if (period == 'Monthly') {
                  if (value < 0 || value > 3) return const Text('');
                }

                List<String> labels = _getLabelsForPeriod(period);
                if (value.toInt() >= 0 && value.toInt() < labels.length) {
                  return Text(
                    labels[value.toInt()],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
        minX: period == 'Monthly' ? -0.5 : 0,
        maxX: period == 'Monthly' ? 3.5 : _getStepData(period).length.toDouble() - 1,
        lineBarsData: [
          LineChartBarData(
            spots: _getStepData(period),
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

  List<FlSpot> _getStepData(String period) {
    Map<String, List<double>> data = {
      'Today': [200, 500, 1200, 800, 1500, 2000, 1800, 600],
      'Weekly': [4000, 4500, 6000, 5500, 7000, 8000, 3000],
      'Monthly': [18000, 22000, 25000, 20000],
    };

    return List.generate(data[period]!.length, (index) {
      return FlSpot(index.toDouble(), data[period]![index]);
    });
  }

  List<String> _getLabelsForPeriod(String period) {
    switch (period) {
      case 'Today': return ['6AM', '9AM', '12PM', '3PM', '6PM', '9PM', '12AM', '3AM'];
      case 'Weekly': return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      case 'Monthly': return ['Week1', 'Week2', 'Week3', 'Week4'];
      default: return [];
    }
  }
}