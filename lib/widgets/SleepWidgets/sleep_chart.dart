import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'chart_period_selector.dart';
import 'sleep_chart_data.dart';

class SleepChart extends StatefulWidget {
  const SleepChart({super.key});

  @override
  State<SleepChart> createState() => _SleepChartState();
}

class _SleepChartState extends State<SleepChart> {
  int? touchedIndex;
  String selectedPeriod = 'Today';

  @override
  Widget build(BuildContext context) {
    List<double> sleepData = getSleepDataForPeriod(selectedPeriod);
    double maxSleep = sleepData.reduce((a, b) => a > b ? a : b);

    return Column(
      children: [
        ChartPeriodSelector(
          selectedPeriod: selectedPeriod,
          onPeriodChanged: (period) {
            setState(() {
              selectedPeriod = period;
              touchedIndex = null;
            });
          },
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTapDown: (_) => setState(() => touchedIndex = null),
          child: Container(
            height: 200,
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 16,
              left: 8,
              right: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: BarChart(
              BarChartData(
                minY: 0,
                maxY: maxSleep + 2,
                groupsSpace: 20,
                barTouchData: BarTouchData(
                  touchCallback: (FlTouchEvent event, barTouchResponse) {
                    if (barTouchResponse != null && barTouchResponse.spot != null) {
                      setState(() {
                        touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                      });
                    }
                  },
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (_, __, ___, ____) => null,
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value < 0 || value >= sleepData.length) {
                          return const Text('');
                        }
                        List<String> labels = getLabelsForPeriod(selectedPeriod);
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            labels[value.toInt()],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                barGroups: getBarGroups(touchedIndex, (index) {
                  setState(() {
                    touchedIndex = index;
                  });
                }, sleepData),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
