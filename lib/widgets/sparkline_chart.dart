import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SparklineChart extends StatelessWidget {
  final List<double> prices;

  const SparklineChart({Key? key, required this.prices}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(enabled: false),
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              prices.length,
              (index) => FlSpot(index.toDouble(), prices[index]),
            ),
            isCurved: true,
            color: Colors.blueAccent,
            barWidth: 2,
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}
