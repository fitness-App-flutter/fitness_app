import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'sleep_chart_data.dart';

class SleepChart extends StatefulWidget {
  const SleepChart({super.key});

  @override
  State<SleepChart> createState() => _SleepChartState();
}

class _SleepChartState extends State<SleepChart> {
  int? touchedIndex;
  List<double> sleepData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSleepData();
  }

  Future<void> _loadSleepData() async {
    final data = await getRealSleepData();
    setState(() {
      sleepData = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final maxSleep = sleepData.isNotEmpty
        ? (sleepData.reduce((a, b) => a > b ? a : b) + 2)
        : 8.0;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                minY: 0,
                maxY: maxSleep,
                barGroups: getBarGroups(touchedIndex, (index) {
                  setState(() => touchedIndex = index);
                }, sleepData),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final days = getWeeklyLabels();
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            days[value.toInt()],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                barTouchData: BarTouchData(
                  touchCallback: (FlTouchEvent event, response) {
                    if (response?.spot != null) {
                      setState(() {
                        touchedIndex = response?.spot?.touchedBarGroupIndex;
                      });
                    }
                  },
                ),
              ),
            ),
          ),
          if (touchedIndex != null) ...[
            const SizedBox(height: 16),
            Text(
              '${getWeeklyLabels()[touchedIndex!]}: '
                  '${sleepData[touchedIndex!].toStringAsFixed(1)}  Hours',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }
}